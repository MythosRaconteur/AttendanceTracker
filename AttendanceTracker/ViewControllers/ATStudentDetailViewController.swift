//
//  ATStudentDetailViewController.swift
//  AttendanceTracker
//
//  Created by Christopher Burns on 12/8/16.
//  Copyright © 2016 Mythos Productions. All rights reserved.
//

import UIKit

class ATStudentDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, DataBrokerRequestor {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var dateJoinedLabel: UILabel!
    @IBOutlet weak var waiverSignedButton: UIButton!
    @IBOutlet weak var freeTrialConpletedButton: UIButton!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    let picker = UIImagePickerController()
    
    private var _model: ATStudent?
    
    var model: ATStudent? {
        get {
            return self._model
        }
        set {
            self._model = newValue
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.model == nil) {
            self.model = ATStudent.init()
        }

        let rb = UIBarButtonItem.init(title: "Save", style: UIBarButtonItemStyle.done, target: self, action: #selector(handleDoneButtonPressed))
        
        self.navigationItem.rightBarButtonItem = rb
        
        self.maleButton.tintColor = UIColor.clear
        self.femaleButton.tintColor = UIColor.clear
        
        self.picker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let student = self.model {
            self.firstNameTextField!.text = student.firstName
            self.lastNameTextField!.text = student.lastName
            self.emailTextField!.text = student.email
            self.phoneNumberTextField!.text = student.phoneNumber
            self.notesTextField!.text = student.notes
            
            if student.gender == .male {
                self.maleButton.isSelected = true
                self.femaleButton.isSelected = false
                
                self.imageView.image = UIImage(named: "VikingManAvatar")
            }
            else {
                self.femaleButton.isSelected = true
                self.maleButton.isSelected = false
                
                self.imageView.image = UIImage(named: "VikingWomanAvatar")
            }
            
            
            let df = DateFormatter()
            df.dateFormat = "M/d/yy"
            
            self.dateJoinedLabel!.text = df.string(from: student.dateJoined)
            
            self.freeTrialConpletedButton.isEnabled = !student.hasCompletedFreeTrial
            self.waiverSignedButton.isEnabled = !student.hasSignedWaiver
            
            self.phoneButton.isHidden = (student.phoneNumber.characters.count == 0)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleDoneButtonPressed(sender: UIBarButtonItem) {
        self.model!.firstName = self.firstNameTextField.text!
        self.model!.lastName = self.lastNameTextField.text!
        self.model!.email = self.emailTextField.text!
        self.model!.phoneNumber = self.phoneNumberTextField.text!
        self.model!.gender = self.maleButton.isSelected ? Gender.male : Gender.female
        self.model!.notes = self.notesTextField.text!
        self.model!.dateJoined = Date()
        
        let broker = ATStudentDataBroker(forRequestor: self)
        broker.saveStudent(self.model!)
    }
    
    
    // MARK: - Event Handlers
    
    @IBAction func handleGenderButtonPressed(_ sender: UIButton) {
        if (sender.tag == 1) {
            self.maleButton.isSelected = true
            self.femaleButton.isSelected = false
            
            UIView.transition(with: self.imageView, duration: 0.7, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
                    self.imageView.image = UIImage(named: "VikingManAvatar")
                }, completion: nil)
        }
        else {
            self.femaleButton.isSelected = true
            self.maleButton.isSelected = false
            
            UIView.transition(with: self.imageView, duration: 0.7, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
                self.imageView.image = UIImage(named: "VikingWomanAvatar")
            }, completion: nil)
        }
    }
    
    @IBAction func handleWaiverButtonPressed(_ sender: UIButton) {
        self.model?.hasSignedWaiver = true
        sender.isEnabled = false
    }
    
    @IBAction func handleTrialButtonPressed(_ sender: UIButton) {
        self.model?.hasCompletedFreeTrial = true
        sender.isEnabled = false
    }
    
    @IBAction func handleAddPhotoButtonPressed(_ sender: UIButton) {
        self.picker.allowsEditing = false
        self.picker.sourceType = .photoLibrary
        self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(self.picker, animated: true, completion: nil)
    }
    
    @IBAction func handleGrouponButtonPressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GrouponListVC") as! ATGrouponListViewController
        
        vc.model = self.model
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func handlePhoneButtonPressed(_ sender: UIButton) {
        let url = URL(string: "telprompt://\(self.phoneNumberTextField.text!)")
        UIApplication.shared.openURL(url!)
    }
    
    // MARK: - ImagePickerController Delegate implementation
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.image = chosenImage
        
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - DataBrokerRequestor implementation
    
    func brokerRequestComplete(_ resultArray: Array<ATModelBase>) {
        
    }
    
    func brokerRequestFailed(_ error: NSError) {
        print("\n\nERROR: \(error)")
    }
}
