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
    var gender: Gender = .male
    var hasSignedWaiver = false
    var hasCompletedFreeTrial = false
    var dateJoined = Date()
    
    var notes: String = ""
    var groupons: [ATGroupon] = [ATGroupon]()
    var isCheckedIn: Bool = false
    
    override func initFromProperties(_ propertiesDictionary: Dictionary<String, AnyObject>) {
        super.initFromProperties(propertiesDictionary)
        
        self.firstName = propertiesDictionary["first_name"] as! String
        self.lastName = propertiesDictionary["last_name"] as! String
        self.email = propertiesDictionary["email"] as! String
        self.phoneNumber = propertiesDictionary["telephone"] as! String
        self.gender = Int(propertiesDictionary["gender"] as! String) == 0 ? .male : .female
        self.hasSignedWaiver = Int(propertiesDictionary["has_waiver"] as! String) == 1
        self.hasCompletedFreeTrial = Int(propertiesDictionary["free_trial_completed"] as! String) == 1
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        self.dateJoined = dateFormatter.date(from: propertiesDictionary["date_joined"] as! String)!
        
        self.notes = propertiesDictionary["notes"] as! String
    }
    
    func fullName() -> String {
        return "\(self.firstName) \(self.lastName)"
    }
    
    func isMale() -> Bool {
        return self.gender == .male
    }
    
    func isFemale() -> Bool {
        return self.gender == .female
    }
}

enum Gender {
    case male
    case female
}
