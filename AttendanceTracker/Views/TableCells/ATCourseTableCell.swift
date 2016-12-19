//
//  ATCourseTableCell.swift
//  AttendanceTracker
//
//  Created by Christopher Burns on 7/7/16.
//  Copyright © 2016 Mythos Productions. All rights reserved.
//

import UIKit

class ATCourseTableCell: ATTableCell {
    @IBOutlet weak var courseTitleLabel: UILabel!
    @IBOutlet weak var courseDateLabel: UILabel!
    
    var model: ATCourse {
        get {
            return self._model as! ATCourse
        }
        set {
            self._model = newValue
            
            self.courseTitleLabel!.text = self.model.name
            
            let df = DateFormatter()
            df.dateFormat = "E M/d @ h:mma"
            self.courseDateLabel!.text = df.string(from: self.model.time! as Date)
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
