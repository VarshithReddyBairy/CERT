//
//  LoginViewController.swift
//  CERT
//
//  Created by JayaShankar Mangina on 10/24/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var logInBtnOut: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    func validateFields() -> String? {
        if userNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            messageAlert(title: "Empty Fields", message: "Please fill all the fields")
        }
        return nil
    }

    
    func messageAlert(title:String, message:String) {
        let errorAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        errorAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { (ACTION) in
            errorAlert.dismiss(animated: true, completion: nil)
        }))
        self.present(errorAlert, animated: true, completion: nil)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        self.showSpinner()
        let error = validateFields()
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (t) in
            self.removeSpinner()
        }
        if error != nil {
            messageAlert(title: "Error", message: error!)
        }else{
            let email = userNameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    self.messageAlert(title: "Login Page Error", message: "\(error!)")
                }
            }
        }
        performSegue(withIdentifier: "dashBoardSegue", sender: UIButton.self)
    }
    
}
