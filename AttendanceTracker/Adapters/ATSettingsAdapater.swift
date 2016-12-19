//
//  ATSettingsAdapater.swift
//  AttendanceTracker
//
//  Created by Christopher Burns on 7/6/16.
//  Copyright © 2016 Mythos Productions. All rights reserved.
//

import Foundation

class ATSettingsAdapter: NSObject {

    class func SettingsData() -> NSDictionary {
        return NSDictionary(contentsOfFile:(Bundle.main.path(forResource: "AttendanceTracker-Settings", ofType: "plist"))!)!
    }
    
    class func URIData() -> NSDictionary {
        return SettingsData().object(forKey: "URIs") as! NSDictionary
    }
    
    class func EndPointData() -> NSDictionary {
        return URIData().object(forKey: "EndPoints") as! NSDictionary
    }
    
    class func EnvironmentBaseURL() -> String {
        return URIData().object(forKey: "EnvironmentBaseDEVURL") as! String
    }
    
    
    //  MARK: - User methods
    
    class func UserData() -> NSDictionary {
        return EndPointData().object(forKey: "User") as! NSDictionary
    }
    
    class func AllUsersURI() -> String {
        return EnvironmentBaseURL() + (UserData().object(forKey: "AllUsers") as! String)
    }
    
    class func RegisterURI() -> String {
        return EnvironmentBaseURL() + (UserData().object(forKey: "Register") as! String)
    }
    
    class func LoginURI() -> String {
        return EnvironmentBaseURL() + (UserData().object(forKey: "Login") as! String)
    }
    
    class func LogoutURI() -> String {
        return EnvironmentBaseURL() + (UserData().object(forKey: "Logout") as! String)
    }
    
    
    //  MARK: - Student methods
    
    class func StudentData() -> NSDictionary {
        return EndPointData().object(forKey: "Student") as! NSDictionary
    }
    
    class func AllStudentsURI() -> String {
        return EnvironmentBaseURL() + (StudentData().object(forKey: "AllStudents") as! String)
    }
    
    class func StudentsEnrolledInCourseURI(_ courseID: Int) -> String {
        return EnvironmentBaseURL() + (StudentData().object(forKey: "StudentsEnrolledInCourse") as! String) + String(courseID)
    }
    
    class func SaveStudentURI() -> String {
        return EnvironmentBaseURL() + (StudentData().object(forKey: "SaveStudent") as! String)
    }
    
    class func ArchiveStudentURI() -> String {
        return EnvironmentBaseURL() + (StudentData().object(forKey: "ArchiveStudent") as! String)
    }
    
    class func DeleteStudentURI() -> String {
        return EnvironmentBaseURL() + (StudentData().object(forKey: "DeleteStudent") as! String)
    }
    
    
    //  MARK: - Course methods
    
    class func CourseData() -> NSDictionary {
        return EndPointData().object(forKey: "Course") as! NSDictionary
    }
    
    class func AllCoursesURI() -> String {
        return EnvironmentBaseURL() + (CourseData().object(forKey: "AllCourses") as! String)
    }
    
    class func CoursesSortedByDayURI() -> String {
        return EnvironmentBaseURL() + (CourseData().object(forKey: "CoursesSortedByDay") as! String)
    }
    
    class func AddCourseURI() -> String {
        return EnvironmentBaseURL() + (CourseData().object(forKey: "AddCourse") as! String)
    }
    
    class func ArchiveCourseURI() -> String {
        return EnvironmentBaseURL() + (CourseData().object(forKey: "ArchiveCourse") as! String)
    }
    
    class func DeleteCourseURI() -> String {
        return EnvironmentBaseURL() + (CourseData().object(forKey: "DeleteCourse") as! String)
    }
    
    class func CheckInStudentsURI() -> String {
        return EnvironmentBaseURL() + (CourseData().object(forKey: "CheckInStudents") as! String)
    }
    
    
    //  MARK: - Groupon methods
    
    class func GrouponData() -> NSDictionary {
        return EndPointData().object(forKey: "Groupon") as! NSDictionary
    }
    
    class func AllGrouponsURI() -> String {
        return EnvironmentBaseURL() + (GrouponData().object(forKey: "AllGroupons") as! String)
    }
    
    class func GrouponByIDURI(_ grouponID: Int) -> String {
        return EnvironmentBaseURL() + (GrouponData().object(forKey:  "GrouponByID") as! String) + String(grouponID)
    }
    
    class func GrouponByCodeURI(_ grouponCode: String) -> String {
        return EnvironmentBaseURL() + (GrouponData().object(forKey: "GrouponByCode") as! String) + grouponCode
    }
    
    class func GrouponsForStudentURI(_ studentID: Int) -> String {
        return EnvironmentBaseURL() + (GrouponData().object(forKey: "GrouponsForStudent") as! String) + String(studentID)
    }
}
