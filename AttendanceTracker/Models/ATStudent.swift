//
//  ATStudent.swift
//  AttendanceTracker
//
//  Created by Christopher Burns on 7/7/16.
//  Copyright © 2016 Mythos Productions. All rights reserved.
//

import UIKit

class ATStudent: ATModelBase {
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var phoneNumber: String = ""
    var gender: Gender = .Male
    var notes: String = ""
    
    override func initFromProperties(_ propertiesDictionary: Dictionary<String, AnyObject>) {
        super.initFromProperties(propertiesDictionary)
        
        firstName = propertiesDictionary["first_name"] as! String
        lastName = propertiesDictionary["last_name"] as! String
        email = propertiesDictionary["email"] as! String
        phoneNumber = propertiesDictionary["telephone"] as! String
        gender = (propertiesDictionary["gender"] as! Int) == 0 ? .Male : .Female
        notes = propertiesDictionary["notes"] as! String
    }
}

enum Gender {
    case Male
    case Female
}
