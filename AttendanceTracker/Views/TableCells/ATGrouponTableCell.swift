//
//  ATGrouponTableCell.swift
//  AttendanceTracker
//
//  Created by Christopher Burns on 12/13/16.
//  Copyright © 2016 Mythos Productions. All rights reserved.
//

import UIKit

class ATGrouponTableCell: ATTableCell {
    @IBOutlet weak var grouponCodeLabel: UILabel!
    @IBOutlet weak var grouponTypeLabel: UILabel!
    @IBOutlet weak var grouponPurchaseDateLabel: UILabel!
    
    var model: ATGroupon {
        get {
            return self._model as! ATGroupon
        }
        set {
            self._model = newValue
            
            self.grouponCodeLabel.text = newValue.grouponNumber.uppercased()
            self.grouponTypeLabel.text = "\(newValue.sessionTotal) sessions, \(newValue.sessionUsedCount) used"
            
            let df = DateFormatter()
            df.dateFormat = "M/d/YY"
            
            self.grouponPurchaseDateLabel.text = df.string(from: newValue.purchaseDate!)
            
            if !newValue.isValid() {
                self.grouponCodeLabel.textColor = UIColor.flakLightGray()
                self.grouponTypeLabel.textColor = UIColor.flakLightGray()
                self.grouponPurchaseDateLabel.textColor = UIColor.flakLightGray()
            }
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
