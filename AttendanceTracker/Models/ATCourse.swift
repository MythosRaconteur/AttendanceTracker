//
//  ATCourse.swift
//  AttendanceTracker
//
//  Created by Christopher Burns on 7/7/16.
//  Copyright © 2016 Mythos Productions. All rights reserved.
//

import UIKit

class ATCourse: ATModelBase {
    var name: String = ""
    var time: Date?
    var recurring: Bool = false
    
    override func initFromProperties(_ propertiesDictionary: Dictionary<String, AnyObject>) {
        super.initFromProperties(propertiesDictionary)
        
        name = propertiesDictionary["course_title"] as! String
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        time = dateFormatter.date(from: propertiesDictionary["class_time"] as! String)!
        recurring = NSString(string: (propertiesDictionary["is_recurring"] as! String)).boolValue
    }
    
    func displayString() -> String {
        let df = DateFormatter()
        var outStr = ""
        
        if self.recurring {
            df.dateFormat = "EEEE"
        }
        else {
            df.dateFormat = "E M/d @ h:mm a"
        }
        
        outStr = df.string(from: self.time!)
        
        return "\(self.name) - \(outStr)"
    }
}
