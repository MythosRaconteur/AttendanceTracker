//
//  ATCourseDataBroker.swift
//  AttendanceTracker
//
//  Created by Christopher Burns on 7/7/16.
//  Copyright © 2016 Mythos Productions. All rights reserved.
//

import UIKit
import Alamofire

class ATCourseDataBroker: ATDataBrokerBase {
    override func basicFetchURL() -> String {
        return ATSettingsAdapter.AllCoursesURI()
    }
    
    override func createModelFrom(_ dataDictionary: Dictionary<String, AnyObject>) -> ATCourse {
        let modelObj = ATCourse()
        
        modelObj.initFromProperties(dataDictionary)
        
        return modelObj
    }
    
    func getCoursesSortedByDay() {
        self.requestFromEndPoint(ATSettingsAdapter.CoursesSortedByDayURI())
    }
    
    func save(_ course: ATCourse) {
        
    }
    
    func checkInStudents(_ studentArray: Array<ATStudent>, forCourse: ATCourse) {
        var studentDict = [String: Any]()
        var studentDictArray = [[String: Any]]()

        for student in studentArray {
            studentDictArray.append(self.convertToDictionary(student))
        }
        
        studentDict["studentArray"] = studentDictArray
        studentDict["courseID"] = forCourse.id
        
        self.submitToEndPoint(ATSettingsAdapter.CheckInStudentsURI(), withJSONData: studentDict)
    }
}
