//
//  ATDataBrokerBase.swift
//  AttendanceTracker
//
//  Created by Christopher Burns on 7/6/16.
//  Copyright © 2016 Mythos Productions. All rights reserved.
//

import UIKit
import Alamofire

protocol DataBrokerRequestor {
    func brokerRequestComplete(_ resultArray: Array<ATModelBase>)
    func brokerRequestFailed(_ error: NSError)
}

class ATDataBrokerBase : NSObject {
    var requestor: DataBrokerRequestor?
    var appDelegate: ATAppDelegate
    
    required override init() {
        self.appDelegate = UIApplication.shared.delegate as! ATAppDelegate
    }
    
    convenience init(forRequestor: DataBrokerRequestor) {
        self.init()
        self.requestor = forRequestor
    }
    
    
    //  MARK: - Mandatory Overrides
    
    func basicFetchURL() -> String {
        fatalError("This method must be overridden")
    }
    
    func createModelFrom(_ dataDictionary: Dictionary<String, AnyObject>) -> ATModelBase {
        fatalError("This method must be overridden")
    }
    
    
    //  MARK: - Private Functions
    
    func handleResultArray(_ anArray: Array<Dictionary<String, AnyObject>>) -> Array<ATModelBase> {
        //	Default behavior is to create instances of served models and collect.
        
        var objArray : Array<ATModelBase> = []
        
        for obj: Dictionary<String, AnyObject> in anArray {
            objArray.append(self.createModelFrom(obj))
        }
        
        return objArray;
    }
    
    
    //  MARK: - API
    
    func requestFromEndPoint(_ atURL: String) {
        if (appDelegate.isConnectedToInternet()) {
            Alamofire.request(.GET, atURL).validate().responseJSON { response in
                switch response.result {
                    case .success:
                        if var resultDict : Dictionary<String, AnyObject> = (response.result.value as! Dictionary<String, AnyObject>) {
                            if resultDict["resultCode"] as! Int == 1 {
                                resultDict["resultArray"] = self.handleResultArray(resultDict["resultArray"] as! Array<Dictionary<String, AnyObject>>)
                                
                                self.requestor!.brokerRequestComplete(resultDict["resultArray"] as! Array<ATModelBase>)
                            }
                        }
                    case .failure(let error):
                        print("ERROR: \(error)")
                }
            }
        }
    }
    
    func submitToEndPoint(_ atURL: String, withJSONData: [String : AnyObject]) {
        if (appDelegate.isConnectedToInternet()) {
            Alamofire.request(.POST, atURL, parameters: withJSONData, encoding: .json)
        }
    }
    
    func fetchAll() {
        self.requestFromEndPoint(self.basicFetchURL())
    }
}
