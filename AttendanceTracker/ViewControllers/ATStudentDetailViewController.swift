//
//  ATStudentDetailViewController.swift
//  AttendanceTracker
//
//  Created by Christopher Burns on 12/8/16.
//  Copyright © 2016 Mythos Productions. All rights reserved.
//

import UIKit

class ATStudentDetailViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var notesTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let rb = UIBarButtonItem.init(title: "Save", style: UIBarButtonItemStyle.done, target: self, action: #selector(handleDoneButtonPressed))
        
        self.navigationItem.rightBarButtonItem = rb
        
        self.maleButton.tintColor = UIColor.clear
        self.femaleButton.tintColor = UIColor.clear
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleDoneButtonPressed(sender: UIBarButtonItem) {
        let student = ATStudent.init()
        
        student.firstName = self.firstNameTextField.text!
        student.lastName = self.lastNameTextField.text!
        student.email = self.emailTextField.text!
        student.phoneNumber = self.phoneNumberTextField.text!
        student.gender = self.maleButton.isSelected ? Gender.Male : Gender.Female
        student.notes = self.notesTextView.text!
        
        print("Saving...")
    }
    
    
    // MARK: - Event Handlers
    
    @IBAction func handleGenderButtonPressed(_ sender: UIButton) {
        if (sender.tag == 1) {
            self.maleButton.isSelected = true
            self.femaleButton.isSelected = false
        }
        else {
            self.femaleButton.isSelected = true
            self.maleButton.isSelected = false
        }
    }
}
