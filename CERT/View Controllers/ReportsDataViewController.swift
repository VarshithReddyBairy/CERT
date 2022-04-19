//
//  ReportsDataViewController.swift
//  CERT
//
//  Created by student on 4/19/22.
//

import UIKit

class ReportsDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = reportsDataTableView.dequeueReusableCell(withIdentifier: "reportsData", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textColor = UIColor.green
        return cell
    }
    

    @IBOutlet weak var reportsDataTableView: UITableView!
    
    var data : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        reportsDataTableView.delegate = self
        reportsDataTableView.dataSource = self
    }
    

    //cell : reportsData

}
