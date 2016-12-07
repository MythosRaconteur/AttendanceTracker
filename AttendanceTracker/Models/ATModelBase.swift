//
//  ATModelBase.swift
//  AttendanceTracker
//
//  Created by Christopher Burns on 7/7/16.
//  Copyright © 2016 Mythos Productions. All rights reserved.
//

import UIKit

class ATModelBase: NSObject {
    var id: Int = 0
    
    func initFromProperties(_ propertiesDictionary: Dictionary<String, AnyObject>) {
        id = Int(propertiesDictionary["id"] as! String)!
    }
    
    func dataBroker() -> ATDataBrokerBase {
        let brokerClassString = self.classForCoder.description() + "DataBroker"
        print(brokerClassString)
        
        let createdClass = NSClassFromString(brokerClassString) as! ATDataBrokerBase.Type
        
        return createdClass.init()
    }
    
    func save() {
        let db: ATDataBrokerBase = self.dataBroker()
    }
}
