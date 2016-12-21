//
//  ATGrouponListViewController.swift
//  AttendanceTracker
//
//  Created by Christopher Burns on 12/12/16.
//  Copyright © 2016 Mythos Productions. All rights reserved.
//

import UIKit

class ATGrouponListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DataBrokerRequestor {
    @IBOutlet weak var grouponTableView: UITableView!
    
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

        let rb = UIBarButtonItem.init(title: "+", style: UIBarButtonItemStyle.done, target: self, action: #selector(handleAddButtonPressed))
        
        self.navigationItem.rightBarButtonItem = rb
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Event Handlers
    
    func handleAddButtonPressed(_ sender: UIButton) {
        let grouponDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "GrouponDetailVC") as! ATGrouponDetailViewController
        
        self.navigationController?.pushViewController(grouponDetailVC, animated: true)
    }
    
    
    // MARK: - UITableViewDataSource/Delegate implementation
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model!.groupons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GrouponCell") as! ATGrouponTableCell
        
        cell.model = self.model!.groupons[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let groupon = self.model?.groupons[indexPath.row]
        let grouponDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "GrouponDetailVC") as! ATGrouponDetailViewController
        
        grouponDetailVC.model = groupon
        
        self.navigationController?.pushViewController(grouponDetailVC, animated: true)
    }
    
    // MARK: - DataBrokerRequestor implementation
    
    func brokerRequestComplete(_ resultArray: Array<ATModelBase>) {
        self.model?.groupons = resultArray as! [ATGroupon]
        
        self.grouponTableView.reloadData()
    }
    
    func brokerRequestFailed(_ error: NSError) {
        print(error)
    }
    

    // MARK: - Private methods
    
    func retrieveGroupons() {
        let broker = ATGrouponDataBroker.init(forRequestor: self)
        broker.getGrouponsForStudent(self.model!)
    }
}
