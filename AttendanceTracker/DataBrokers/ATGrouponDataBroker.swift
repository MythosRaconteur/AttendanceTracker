//
//  ATGrouponDataBroker.swift
//  AttendanceTracker
//
//  Created by Christopher Burns on 12/12/16.
//  Copyright © 2016 Mythos Productions. All rights reserved.
//

import UIKit

class ATGrouponDataBroker: ATDataBrokerBase {
    override func basicFetchURL() -> String {
        return ATSettingsAdapter.AllGrouponsURI()
    }
    
    func getGrouponsForStudent(_ student: ATStudent) {
        self.requestFromEndPoint(ATSettingsAdapter.GrouponsForStudentURI(student.id))
    }
    
    func getGrouponBy(code: String) {
        self.requestFromEndPoint(ATSettingsAdapter.GrouponByCodeURI(code))
    }
    
    override func createModelFrom(_ dataDictionary: Dictionary<String, AnyObject>) -> ATGroupon {
        let modelObj = ATGroupon()
        
        modelObj.initFromProperties(dataDictionary)
        
        return modelObj
    }

}
