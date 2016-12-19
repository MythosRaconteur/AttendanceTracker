//
//  ATStudentListViewController.swift
//  AttendanceTracker
//
//  Created by Christopher Burns on 7/7/16.
//  Copyright © 2016 Mythos Productions. All rights reserved.
//

import UIKit

class ATStudentListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DataBrokerRequestor {
    @IBOutlet weak var studentListTableView: UITableView!
    @IBOutlet weak var addStudentButton: UIButton!
    
    var studentArray: [ATStudent] = [ATStudent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let broker = ATStudentDataBroker.init(forRequestor: self)
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
    

    // MARK: - UITableViewDataSource/Delegate implementation
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.studentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentListCell") as! ATStudentTableCell
        
        cell.model = self.studentArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "StudentDetailVC") as! ATStudentDetailViewController
        
        detailVC.model = self.studentArray[indexPath.row]
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    // MARK: - DataBrokerRequestor implementation
    
    func brokerRequestComplete(_ resultArray: Array<ATModelBase>) {
        self.studentArray = resultArray as! [ATStudent]
        
        self.studentListTableView.reloadData()
    }
    
    func brokerRequestFailed(_ error: NSError) {
        print(error)
    }

}
