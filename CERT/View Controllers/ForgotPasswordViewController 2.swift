//
//  ForgotPasswordViewController.swift
//  CERT
//
//  Created by JayaShankar Mangina on 10/28/21.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {
    @IBOutlet weak var resetEmail: UITextField!
    @IBOutlet weak var resetPasswordBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(doneFunction))

        // Do any additional setup after loading the view.
    }
    
    func messageAlert(title:String, message:String) {
        let errorAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        errorAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { (ACTION) in
            errorAlert.dismiss(animated: true, completion: nil)
        }))
        self.present(errorAlert, animated: true, completion: nil)
    }
    
    @objc func doneFunction(){
        dismiss(animated: true)
    }
    
    @IBAction func resetEmail(_ sender: UITextField) {
        let input = resetEmail.text!
        if input.isEmpty {
            resetPasswordBtn.isEnabled = false
            resetPasswordBtn.isHidden = true
        }
        resetPasswordBtn.isHidden = false
        resetPasswordBtn.isEnabled = true
    }
    
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
