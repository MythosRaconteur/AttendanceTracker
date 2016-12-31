//
//  ATCourseDetailViewController.swift
//  AttendanceTracker
//
//  Created by Christopher Burns on 7/8/16.
//  Copyright © 2016 Mythos Productions. All rights reserved.
//

import UIKit

class ATCourseDetailViewController: UIViewController, DataBrokerRequestor {
    @IBOutlet weak var classTitleTextField: UITextField?
    @IBOutlet weak var startDateButton: UIButton?
    @IBOutlet weak var saveButton: UIButton?
    @IBOutlet weak var datePickerContainerView: UIView?
    @IBOutlet weak var startDatePicker: UIDatePicker?
    @IBOutlet weak var isRecurringSwitch: UISwitch?
    @IBOutlet var datePickerContainerHeightConstraint: NSLayoutConstraint!
    
    var model: ATCourse?
    var isSelectingDate: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (self.model != nil) {
            let df: DateFormatter = DateFormatter()
            df.dateFormat = "E MMM d, yyyy @ h:mma"
            
            self.classTitleTextField!.text = self.model?.name
            self.startDateButton!.setTitle(df.string(from: (self.model?.time)! as Date), for: UIControlState())
            self.startDatePicker!.setDate((self.model?.time)! as Date, animated: true)
            self.isRecurringSwitch!.isOn = (self.model?.recurring)!
        }
        else {
            self.model = ATCourse()
            self.startDateButton!.setTitle("set start date", for: UIControlState())
        }
    }
    
    
    //  MARK: - Event Handlers
    
    @IBAction func handleStartDateButtonPressed(_ sender: UIButton) {
        let df: DateFormatter = DateFormatter()
        df.dateFormat = "E MMM d, yyyy @ h:mma"

        isSelectingDate = !isSelectingDate
        
        self.view.layoutIfNeeded()
        
        if (isSelectingDate) {
            var buttonTitle: String = "SELECT DATE"
            
            if !self.model!.isNew() {
                buttonTitle = "SET TO:  " + df.string(from: (self.model?.time)! as Date)
            }
            
            UIView.animate(withDuration: 0.5, animations: {
                self.datePickerContainerHeightConstraint.constant = 150
                self.view.layoutIfNeeded()
                self.startDateButton!.setTitle(buttonTitle, for: UIControlState())
            }) 
            
            UIView.animate(withDuration: 0.3, delay: 0.2, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.datePickerContainerView?.alpha = 1
            }, completion: nil)
        }
        else {
            self.model!.time = self.startDatePicker?.date
            
            UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.datePickerContainerView?.alpha = 0
                self.startDateButton!.setTitle(df.string(from: (self.model?.time)! as Date), for: UIControlState())
                }, completion: { finished in
                    UIView.animate(withDuration: 0.3, animations: {
                        self.datePickerContainerHeightConstraint.constant = 0
                        self.view.layoutIfNeeded()
                    }) 
            })
        }
    }
    
    
    //  MARK: - Event Handlers
    
    @IBAction func handleDatePickerValueChanged(_ sender: UIDatePicker) {
        let df: DateFormatter = DateFormatter()
        df.dateFormat = "E MMM d, yyyy @ h:mma"
        
        let buttonTitle: String = df.string(from: (self.startDatePicker?.date)!)

        self.startDateButton!.setTitle("SET TO:  " + buttonTitle, for: UIControlState())
    }
    
    @IBAction func handleSaveButtonPressed(_ sender: UIButton) {
        self.model!.name = (self.classTitleTextField?.text)!
        self.model!.recurring = (self.isRecurringSwitch?.isOn)!
        
        let dataBroker: ATCourseDataBroker = self.model?.dataBroker() as! ATCourseDataBroker
        dataBroker.requestor = self
        
        dataBroker.save(self.model!)
    }
    
    
    //  MARK: - DataBrokerRequestor implementation
    
    func brokerRequestFailed(_ error: NSError) {
        print("ERROR: \(error)")
    }
    
    func brokerRequestComplete(_ resultArray: Array<ATModelBase>) {
        print("SUCCESSFULLY SAVED COURSE: \(self.model!.name)")
    }
}
