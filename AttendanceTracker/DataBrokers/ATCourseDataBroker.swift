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
        var studentIDArray = [Int]()

        for student in studentArray {
            studentIDArray.append(student.id)
        }
        
//        studentDict["studentArray"] = [["id":5, "firstName": "Chris", "lastName": "Burns"], ["id":7, "firstName": "Peer", "lastName": "Sangngern"]]
        studentDict["studentIDArray"] = studentIDArray
        studentDict["courseID"] = forCourse.id
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        studentDict["classDate"] = df.string(from: Date())
        
        self.submitToEndPoint(ATSettingsAdapter.CheckInStudentsURI(), withJSONData: studentDict)
    }
}
