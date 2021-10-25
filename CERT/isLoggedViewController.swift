//
//  isLoggedViewController.swift
//  CERT
//
//  Created by student on 10/25/21.
//

import UIKit

class isLoggedViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    var isLogge = false
    override func viewDidLoad() {
        super.viewDidLoad()

        if isLogge{
            displayLabel.text = "Login Successfull"
            displayLabel.textColor = UIColor.green
        }
        else{
            displayLabel.text = "Login failed"
            displayLabel.textColor = UIColor.red
        }
    }
    

   

}
