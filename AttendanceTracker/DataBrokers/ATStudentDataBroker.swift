//
//  ATStudentDataBroker.swift
//  AttendanceTracker
//
//  Created by Christopher Burns on 7/8/16.
//  Copyright © 2016 Mythos Productions. All rights reserved.
//

import UIKit

class ATStudentDataBroker: ATDataBrokerBase {
    override func basicFetchURL() -> String {
        return ATSettingsAdapter.AllStudentsURI()
    }
    
    override func createModelFrom(_ dataDictionary: Dictionary<String, AnyObject>) -> ATStudent {
        let modelObj = ATStudent()
        
        modelObj.initFromProperties(dataDictionary)
        
        return modelObj
    }
}
