//
//  ATStudentCheckInTableCell.swift
//  AttendanceTracker
//
//  Created by Christopher Burns on 7/7/16.
//  Copyright © 2016 Mythos Productions. All rights reserved.
//

import UIKit

class ATStudentCheckInTableCell: ATTableCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkInImageView: UIImageView!
    
    var accView = UIImageView.init()
    
    var model: ATStudent {
        get {
            return self._model as! ATStudent
        }
        set {
            self._model = newValue
            
            self.nameLabel!.text = newValue.fullName()
            
            self.nameLabel.textColor = (newValue.isMale()) ? UIColor.flakMaleBlue : UIColor.flakFemalePink
            
            let xPoint = self.contentView.frame.origin.x + self.contentView.frame.size.width - 50
            let yPoint = (self.contentView.frame.origin.y + self.contentView.frame.size.height) / 2
            
            let circlePath = UIBezierPath(arcCenter: CGPoint(x: xPoint,y: yPoint), radius: CGFloat(7), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circlePath.cgPath
            
            //change the fill color
            shapeLayer.fillColor = (newValue.hasSignedWaiver) ? UIColor.flakTeal.cgColor : UIColor.flakLightGray.cgColor
            
            self.contentView.layer.addSublayer(shapeLayer)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        let iv = UIImageView.init()
        iv.contentMode = .center
        
        iv.image = UIImage(named:"CheckInCheckmarkIcon")
        
        self.accView = iv
    }
    
    func select() {
        self.model.isCheckedIn = true
        self.accessoryView = self.accView
    }
    
    func deselect() {
        self.model.isCheckedIn = false
        self.accessoryView = nil
        
    }
}
