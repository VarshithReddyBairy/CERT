//
//  isLoggedViewController.swift
//  CERT
//
//  Created by CERT on 10/25/21.
//

import UIKit

class isLoggedViewController: UIViewController {

    @IBOutlet weak var messageView: UITextView!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var displayLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = "Welcome!"
        subjectLabel.text = "You're on the Waitlist."
        messageView.text = "You'll be notified, when your request got Approved. Thanks for your patience. You may now exit the application"
    }
    

   

}
