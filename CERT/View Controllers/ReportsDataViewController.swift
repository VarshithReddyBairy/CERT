//
//  ReportsDataViewController.swift
//  CERT
//
//  Created by Vineetha Batchu on 4/26/22.
//

import UIKit

class ReportsDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = reportsDataTableView.dequeueReusableCell(withIdentifier: "reportsData", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    var data : [String] = []

    @IBOutlet weak var reportsDataTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        reportsDataTableView.delegate = self
        reportsDataTableView.dataSource = self
        
    }
    

    

}
