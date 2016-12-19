//
//  ATStudentTableCell.swift
//  AttendanceTracker
//
//  Created by Christopher Burns on 7/7/16.
//  Copyright © 2016 Mythos Productions. All rights reserved.
//

import UIKit

class ATStudentTableCell: ATTableCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateJoinedLabel: UILabel!
    @IBOutlet weak var waiverLabel: UILabel!
    @IBOutlet weak var freeTrialLabel: UILabel!
    
    var model: ATStudent {
        get {
            return self._model as! ATStudent
        }
        set {
            self._model = newValue
            
            self.nameLabel!.text = newValue.fullName()
            
            self.nameLabel.textColor = (newValue.isMale()) ? UIColor.flakMaleBlue() : UIColor.flakFemalePink()
            
            let df = DateFormatter()
            df.dateFormat = "M/d/yy"
            
            self.dateJoinedLabel.text = df.string(from: newValue.dateJoined)
            
            self.waiverLabel.textColor = (newValue.hasSignedWaiver) ? UIColor.black : UIColor.flakLightGray()
            
            self.freeTrialLabel.textColor = (newValue.hasCompletedFreeTrial) ? UIColor.black : UIColor.flakLightGray()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
