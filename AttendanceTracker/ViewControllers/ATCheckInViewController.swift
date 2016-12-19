//
//  ATCheckInViewController.swift
//  AttendanceTracker
//
//  Created by Christopher Burns on 7/7/16.
//  Copyright © 2016 Mythos Productions. All rights reserved.
//

import UIKit

class ATCheckInViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, DataBrokerRequestor {

    @IBOutlet weak var coursePicker: UIPickerView!
    @IBOutlet weak var classSelectButton: UIButton!
    @IBOutlet weak var studentTableView: UITableView!
    @IBOutlet weak var classPickerHeightContstraint: NSLayoutConstraint!
    @IBOutlet weak var dimView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    
    var courseArray = [ATCourse]()
    var studentArray = [ATStudent]()
    
    var selectedCourse: ATCourse?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let broker = ATCourseDataBroker.init(forRequestor: self)
        broker.getCoursesSortedByDay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Event Handlers
    
    @IBAction func handleClassSelectButtonPressed(_ sender: UIButton) {
        self.classPickerHeightContstraint.constant = 132
        self.view.setNeedsLayout()
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
            self.dimView.alpha = 1.0
        })
    }
    
    @IBAction func handleDoneButtonPressed(_ sender: UIButton) {
        let checkedInStudentsArray = self.studentArray.filter { (student) in
            student.isCheckedIn
        }
        
        let broker = ATCourseDataBroker(forRequestor: self)
        broker.checkInStudents(checkedInStudentsArray, forCourse: self.selectedCourse!)
    }
    
    
    //  MARK: - UITableViewDelegate/DataSource implementation
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.studentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCheckInCell") as! ATStudentCheckInTableCell
        
        cell.model = self.studentArray[indexPath.row]
        cell.accessoryType = cell.model.isCheckedIn ? .checkmark : .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ATStudentCheckInTableCell
        
        cell.select()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ATStudentCheckInTableCell
        
        cell.deselect()
    }
    
    
    //  MARK: - UIPickerViewDataSource/Delegate implementation
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.courseArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = view as! UILabel!
        
        if label == nil {
            label = UILabel()
        }
        
        let title = NSAttributedString(string: self.courseArray[row].displayString(), attributes: [NSFontAttributeName: UIFont(name: "Futura-Medium", size: 16)!])
        
        label?.attributedText = title
        label?.textAlignment = .center
        
        return label!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedCourse = self.courseArray[row]
        
        self.classPickerHeightContstraint.constant = 0
        self.view.setNeedsLayout()
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.dimView.alpha = 0.0
        })
        
        self.updateClassSelectButton()
        
        let broker = ATStudentDataBroker.init(forRequestor: self)
        broker.getStudentsForCourse(self.selectedCourse!)
    }
    
    
    //  MARK: - DataBrokerRequestor implementation
    
    func brokerRequestFailed(_ error: NSError) {
        print("ERROR: \(error)")
    }
    
    func brokerRequestComplete(_ resultArray: Array<ATModelBase>) {
        if resultArray.count > 0 {
            if resultArray[0] is ATCourse {
                self.courseArray = resultArray as! [ATCourse]
                
                self.pickerView(self.coursePicker, didSelectRow: 0, inComponent: 0)
            }
            else {
                self.studentArray = resultArray as! [ATStudent]
                
                self.studentTableView.reloadData()
            }
        }
    }
    
    
    // MARK: - Private Methods
    
    private func updateClassSelectButton() {
        var str = "SELECT CLASS"
        
        self.classSelectButton.titleLabel?.font = UIFont(name: "Futura-Medium", size: 20)
        
        if let course = self.selectedCourse {
            str = course.displayString()
            self.classSelectButton.titleLabel?.font = UIFont(name: "Futura-Medium", size: 14)
        }
        
        self.classSelectButton.setTitle(str, for: .normal)
    }
}
