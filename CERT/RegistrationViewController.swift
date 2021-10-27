//
//  RegistrationViewController.swift
//  CERT
//
//  Created by JayaShankar Mangina on 10/24/21.
//

import UIKit

class Auth{
    var uname : String?
    var pass : String?
    init(uname : String , pass : String){
        self.uname = uname
        self.pass = pass
    }
}

class RegistrationViewController: UIViewController {
var login = [Auth]()
    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var PasswordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
    @IBAction func submitButton(_ sender: Any) {
        
        let user = Auth(uname: userNameField.text!, pass: PasswordField.text!)
        login.append(user)
    }
    
}
