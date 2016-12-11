//
//  ATDataBrokerBase.swift
//  AttendanceTracker
//
//  Created by Christopher Burns on 7/6/16.
//  Copyright © 2016 Mythos Productions. All rights reserved.
//

import UIKit
import Alamofire
import Foundation

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
        print(atURL)
        if (appDelegate.isConnectedToInternet()) {
            Alamofire.request(atURL).validate().responseJSON { response in
                switch response.result {
                    case .success:
                        var resultDict = response.result.value as! Dictionary<String, AnyObject>
                        
                        if resultDict["resultCode"] as! Int == 1 {
                            let objArray = self.handleResultArray(resultDict["resultArray"] as! Array<Dictionary<String, AnyObject>>)
                            
                            resultDict["resultArray"] = objArray as AnyObject?
                            
                            self.requestor!.brokerRequestComplete(resultDict["resultArray"] as! Array<ATModelBase>)
                        }
                    
                        break
                    case .failure(let error):
                        print("ERROR: \(error)")
                    
                        break
                }
            }
        }
    }
    
    func submitToEndPoint(_ atURL: String, withJSONData: [String : AnyObject]) {
//        if (appDelegate.isConnectedToInternet()) {
//            Alamofire.request(atURL, method: .post parameters: withJSONData, encoding: .json)
//        }
    }
    
    func fetchAll() {
        self.requestFromEndPoint(self.basicFetchURL())
    }
}
