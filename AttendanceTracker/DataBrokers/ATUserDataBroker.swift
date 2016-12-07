//
//  ATUserDataBroker.swift
//  AttendanceTracker
//
//  Created by Christopher Burns on 7/8/16.
//  Copyright © 2016 Mythos Productions. All rights reserved.
//

import UIKit

class ATUserDataBroker: ATDataBrokerBase {
    override func basicFetchURL() -> String {
        return ATSettingsAdapter.AllUsersURI()
    }
    
    override func createModelFrom(_ dataDictionary: Dictionary<String, AnyObject>) -> ATUser {
        let modelObj = ATUser()
        
        modelObj.initFromProperties(dataDictionary)
        
        return modelObj
    }
}
