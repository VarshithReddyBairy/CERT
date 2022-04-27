//
//  ViewController.swift
//  CERT
//
//  Created by JayaShankar Mangina on 10/24/21.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signUpClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "signUpSegue", sender: UIButton.self)
    }
    

    @IBAction func loginButtonClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "loginSegue", sender: UIButton.self)
    }
    
}

