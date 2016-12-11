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
    
    var courseArray = [ATCourse]()
    var selectedCourse: ATCourse?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let broker = ATCourseDataBroker.init(forRequestor: self)
        broker.fetchAll()
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedCourse = self.courseArray[row]
        
        self.classPickerHeightContstraint.constant = 0
        self.view.setNeedsLayout()
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.dimView.alpha = 0.0
        })
        
        self.updateClassSelectButton()
    }
    
    
    //  MARK: - UITableViewDelegate/DataSource implementation
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: PokemonTableCell = tableView.dequeueReusableCellWithIdentifier("pokemonTableCellID")! as! PokemonTableCell
//        
//        cell.model = pokemonArray[indexPath.row] as? Pokemon
//        
//        return cell
        
        return UITableViewCell.init()
    }
    
    
    //  MARK: - UIPickerViewDelegate implementation
    
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
        
        let title = NSAttributedString(string: self.getTitleFor(course: self.courseArray[row]), attributes: [NSFontAttributeName: UIFont(name: "Futura-Medium", size: 16)!])
        
        label?.attributedText = title
        label?.textAlignment = .center
        
        return label!
    }
    
    
    //  MARK: - DataBrokerRequestor implementation
    
    func brokerRequestFailed(_ error: NSError) {
        print("ERROR: \(error)")
    }
    
    func brokerRequestComplete(_ resultArray: Array<ATModelBase>) {
        self.courseArray = resultArray as! [ATCourse]
    }
    
    
    // MARK: - Private Methods
    
    func getTitleFor(course: ATCourse) -> String {
        let df = DateFormatter()
        df.dateFormat = "E M/d @ h:mm a"
        
        return "\(course.name) - \(df.string(from: course.time!))"
    }
    
    func updateClassSelectButton() {
        var str = "SELECT CLASS"
        
        self.classSelectButton.titleLabel?.font = UIFont(name: "Futura-Medium", size: 20)
        
        if let course = self.selectedCourse {
            str = self.getTitleFor(course: course)
            self.classSelectButton.titleLabel?.font = UIFont(name: "Futura-Medium", size: 14)
        }
        
        self.classSelectButton.setTitle(str, for: .normal)
    }
}
