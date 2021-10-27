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
     var uName : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        if isLogge{
            displayLabel.text = "Welcome to CERT \((uName)!)"
            displayLabel.textColor = UIColor.green
        }
        else{
            displayLabel.text = "Please Enter correct username or password"
            displayLabel.textColor = UIColor.red
        }
    }
    

   

}
