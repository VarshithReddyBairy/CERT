//
//  ForgotPasswordViewController.swift
//  CERT
//
//  Created by CERT on 10/28/21.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {

// MARK: 1 - IBOutlets for Reset Email and Reset Password Button
    @IBOutlet weak var resetEmail: UITextField!
    @IBOutlet weak var resetPasswordBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
// MARK: 2 - NavBar Button for canceling the operation
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(doneFunction))
    }
    
// MARK: 3 - Function to trigger Message Alert
    func messageAlert(title:String, message:String) {
        let errorAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        errorAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { (ACTION) in
            errorAlert.dismiss(animated: true, completion: nil)
        }))
        self.present(errorAlert, animated: true, completion: nil)
    }

// MARK: 4 - Function to dismiss the Presented Controller
    @objc func doneFunction(){
        dismiss(animated: true)
    }

// MARK: 5 - Function to carry out Reset Email
    @IBAction func resetEmail(_ sender: UITextField) {
        let input = resetEmail.text!
        if input.isEmpty {
            resetPasswordBtn.isEnabled = false
            resetPasswordBtn.isHidden = true
        }
        resetPasswordBtn.isHidden = false
        resetPasswordBtn.isEnabled = true
    }

// MARK: 6 - Function to carry out when Reset button is Clicked
    @IBAction func resetTapped(_ sender: UIButton) {
        Auth.auth().sendPasswordReset(withEmail: resetEmail.text!) { (error) in
            if error == nil{
                self.messageAlert(title: "Reset Password Success", message: "Your password has been successfully Reset")
                print("SUCESS!")
            }else{
                self.messageAlert(title: "Reset Password Fail", message: "Your password has not been Reset. Please Try again.")
                print("FAIL")
            }
        }
        resetEmail.text! = ""
        resignFirstResponder()
        
    }
    
}
