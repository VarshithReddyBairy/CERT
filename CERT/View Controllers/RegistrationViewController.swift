//
//  RegistrationViewController.swift
//  CERT
//
//  Created by JayaShankar Mangina on 10/24/21.
//

import UIKit
import FirebaseAuth
import Firebase

class RegistrationViewController: UIViewController {
    
    let roles = ["--Select Role--","Admin","User","Volunteer"]
    var pickerView = UIPickerView()
    
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var contactNumberField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var roleSelectField: UITextField!
    @IBOutlet weak var passwdField: UITextField!
    @IBOutlet weak var verifyPasswdField: UITextField!
    @IBOutlet weak var certifyField: UITextField!
    @IBOutlet weak var lawOfficerField: UITextField!
    @IBOutlet weak var signUpBtnOutlt: UIButton!
    
    override func viewDidLoad() {
        pickerView.delegate = self
        pickerView.dataSource = self
        roleSelectField.inputView  = pickerView
        roleSelectField.textAlignment = .center
    }
    
    func validateFields() -> String? {
        if firstNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || contactNumberField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwdField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            verifyPasswdField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            certifyField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lawOfficerField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            roleSelectField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            messageAlert(title: "Empty Fields", message: "Please fill all the fields")
        }
        
        let cleanedPasswd = passwdField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if isPasswordValid(cleanedPasswd) == false{
            messageAlert(title: "Password Field Empty", message: "Please make sure your password has atleast: 8 Characters, a special character and a number")
            
        }
        
        return nil
    }
    
    func isPasswordValid(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    func messageAlert(title:String, message:String) {
        let errorAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        errorAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { (ACTION) in
            errorAlert.dismiss(animated: true, completion: nil)
        }))
        self.present(errorAlert, animated: true, completion: nil)
    }
    
    func transitionToDashboard() {
        let isLoginViewController = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        view.window?.rootViewController = isLoginViewController
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func signUpClicked(_ sender: UIButton) {
        let error = validateFields()
        
        if error != nil {
            messageAlert(title: "Error", message: error!)
        }
        else{
            let firstName = firstNameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let contactNumber = contactNumberField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwdField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let verifyPassword = verifyPasswdField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let hasCertifications = certifyField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let isLawOfficer = lawOfficerField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let roleOpted = roleSelectField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if err != nil{
                    self.messageAlert(title: "Account Sign up Error", message: "Error Creating user")
                }
                else{
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstName": firstName,
                                                              "lastName": lastName,
                                                              "uid": result!.user.uid,
                                                              "email": email,
                                                              "contactNumber": contactNumber,
                                                              "hasCertifications": hasCertifications,
                                                              "isLawOfficer": isLawOfficer,
                                                              "role": roleOpted,
                                                              "password": password,
                                                              "verifyPassword": verifyPassword]) { (error) in
                        if error != nil {
                            self.messageAlert(title: "User Account Error", message: "Error Saving User data")
                        }
                    }
                    //Transition to User dashboard
                    self.messageAlert(title: "Sign Up Success", message: "Your User Account is Succesfully Created")
                    self.transitionToDashboard()
                }
            }
        }
    }
}

extension RegistrationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return roles.count
}
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return roles[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        roleSelectField.text = roles[row]
        roleSelectField.resignFirstResponder()
    }

}


