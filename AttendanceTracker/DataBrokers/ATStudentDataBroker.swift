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
    
    func getStudentsForCourse(_ course: ATCourse) {
        self.requestFromEndPoint(ATSettingsAdapter.StudentsEnrolledInCourseURI(course.id))
    }
    
    func saveStudent(_ student: ATStudent) {
        var json = self.convertToDictionary(student)
        
        json["hasSignedWaiver"] = student.hasSignedWaiver ? 1 : 0
        json["hasCompletedFreeTrial"] = student.hasCompletedFreeTrial ? 1 : 0
        json["gender"] = student.gender == .female ? 1 : 0
        
        self.submitToEndPoint(ATSettingsAdapter.SaveStudentURI(), withJSONData: json)
    }
}
