//
//  ATGroupon.swift
//  AttendanceTracker
//
//  Created by Christopher Burns on 12/12/16.
//  Copyright © 2016 Mythos Productions. All rights reserved.
//

import UIKit

class ATGroupon: ATModelBase {
    var grouponNumber: String = ""
    var grouponType: String = ""
    var purchaseDate: Date?
    var expirationDate: Date?
    var sessionTotal: Int = 0
    var sessionUsedCount: Int = 0
    var hasBeenRedeemed: Bool = false

    override func initFromProperties(_ propertiesDictionary: Dictionary<String, AnyObject>) {
        super.initFromProperties(propertiesDictionary)
        
        self.grouponNumber = propertiesDictionary["groupon_code"] as! String
//        self.grouponType = propertiesDictionary["groupon_type"] as! String
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        self.purchaseDate = dateFormatter.date(from: (propertiesDictionary["purchase_date"] as! String))
        
        if let expDate = propertiesDictionary["expiration_date"] as? String {
            self.expirationDate = dateFormatter.date(from: expDate)
        }
        
        
        self.sessionTotal = Int(propertiesDictionary["session_count"] as! String)!
        self.sessionUsedCount = Int(propertiesDictionary["sessions_used"] as! String)!
        
        self.hasBeenRedeemed = Int(propertiesDictionary["is_redeemed"] as! String)! == 1
    }
    
    func isValid() -> Bool {
        if self.expirationDate != nil {
            return self.expirationDate! >= Date() && self.sessionUsedCount < self.sessionTotal
        }
        
        return self.sessionUsedCount < self.sessionTotal
    }
}
