//
//  ATCourseListViewController.swift
//  AttendanceTracker
//
//  Created by Christopher Burns on 7/7/16.
//  Copyright © 2016 Mythos Productions. All rights reserved.
//

import UIKit

class ATCourseListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DataBrokerRequestor {
    @IBOutlet weak var courseTableView: UITableView!
    
    var courseArray: [ATCourse] = []

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
    
    
    //  MARK: - UITableViewDelegate/DataSource implementation
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ATCourseTableCell = tableView.dequeueReusableCell(withIdentifier: "courseTableCellID")! as! ATCourseTableCell

        cell.model = courseArray[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let course = courseArray[indexPath.row]
        let courseDetailVC: ATCourseDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "CourseDetailVC") as! ATCourseDetailViewController
        courseDetailVC.model = course
        
        self.navigationController?.pushViewController(courseDetailVC, animated: true)
    }
    
    
    //  MARK: - DataBrokerRequestor implementation
    
    func brokerRequestFailed(_ error: NSError) {
        print("ERROR: \(error)")
    }
    
    func brokerRequestComplete(_ resultArray: Array<ATModelBase>) {
        courseArray.append(contentsOf: resultArray as! Array<ATCourse>)
        
        self.courseTableView.reloadData()
    }
}
