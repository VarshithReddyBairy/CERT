//
//  ViewController.swift
//  CERT
//
//  Created by JayaShankar Mangina on 10/24/21.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "signUpSegue", sender: UIButton.self)
    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "loginSegue", sender: UIButton.self)
    }
    
    @IBAction func unwind(_ seg: UIStoryboardSegue){
        
    }

}

