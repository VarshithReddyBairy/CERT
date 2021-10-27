//
//  LoginViewController.swift
//  CERT
//
//  Created by JayaShankar Mangina on 10/24/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    var isLogged = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginButtonPressed(_ sender: Any) {
        if userNameField.text == "varshith"   && passwordField.text == "varshith"{
            isLogged = true
        }
        if userNameField.text == "jayashanker"   && passwordField.text == "jayashanker"{
            isLogged = true
        }
        if userNameField.text == "shital"   && passwordField.text == "shital"{
            isLogged = true
        }
        if userNameField.text == "sharada"   && passwordField.text == "sharada"{
            isLogged = true
        }
        if userNameField.text == "vinay"   && passwordField.text == "vinay"{
            isLogged = true
        }
        if userNameField.text == "vineetha"   && passwordField.text == "vineetha"{
            isLogged = true
        }
        if userNameField.text == "amulya"   && passwordField.text == "amulya"{
            isLogged = true
        }
        if userNameField.text == "admin"   && passwordField.text == "admin"{
            isLogged = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let transition = segue.identifier
        
        if transition == "isLogged"{
            let destination = segue.destination as! isLoggedViewController
            destination.isLogge = isLogged
            destination.uName = userNameField.text!
        }
        isLogged = false
    }
}
