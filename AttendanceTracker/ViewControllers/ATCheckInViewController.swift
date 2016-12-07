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
    @IBOutlet weak var allClassesToggleButton: UIButton!
    @IBOutlet weak var studentTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let broker = ATCourseDataBroker.init(forRequestor: self)
        broker.fetchAll()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func handleAllClassToggleButtonPressed(_ sender: UIButton) {
        
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
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 0
    }
    
    
    //  MARK: - DataBrokerRequestor implementation
    func brokerRequestFailed(_ error: NSError) {
        print("ERROR: \(error)")
    }
    
    func brokerRequestComplete(_ resultArray: Array<ATModelBase>) {
        print("RESULT: \(resultArray)")
    }
}
