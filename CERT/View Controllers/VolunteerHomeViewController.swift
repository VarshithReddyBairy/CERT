//
//  VolunteerHomeViewController.swift
//  CERT
//
//  Created by JayaShankar Mangina on 2/21/22.
//

import UIKit
import StoreKit
import FirebaseAuth
import Firebase
import FirebaseDatabase
import FirebaseFirestore

class UserDetails{
    
}

class VolunteerHomeViewController: UIViewController {

    @IBOutlet weak var customTabBarView: UIView!
    var userName : String?
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var reportBtnOutlet: UIButton!
    @IBOutlet weak var volunteerImageView: UIImageView!
    @IBOutlet weak var chatViewButtonOutlet: RoundButton!
    @IBOutlet weak var profileBtnOutlet: UIButton!
    @IBOutlet weak var viewReportsBtnOutlet: UIButton!
    
    var lastName: String = ""
        var streetAddress: String = ""
        var firstName: String = ""
        var emailAddress: String = ""
        var qualification: String = ""
        var state: String = ""
        var verifyPassword: String = ""
        var createdAt: String = ""
        var city: String = ""
        var others: String = ""
        var contactNumber: String = ""
        
        
        var reportsArray : [Dictionary<String, Any>] = []
//    var details = ["First Name: Sharada", "Last Name : Noothalapati", "Contact Number : 2246078708" , "EmailId : sharadanoothalapati@gmail.com" , "Address : 1121 N College Dr", "City : Maryville", "State : Missouri", "Qualification : CERT Trainee"]
//
    
    var details :  [ String] = []
        var detailsUpdated : [String] = []
    
    override func viewDidLoad() {
        generateRoundButtons()
        generateTabBar()
        super.viewDidLoad()
        navigationItem.title = ""
        if Auth.auth().currentUser != nil {
            userName = Auth.auth().currentUser?.email
            greetingLabel.text = "Welcome, "+userName!
            let uid = Auth.auth().currentUser?.uid
            print("uid : \(uid!)")

            
            
            let db = Firestore.firestore()
            db.collection("usersDB").whereField("emailAddress", isEqualTo: userName!).getDocuments{(snapshot ,error) in
                            if error == nil {

                                for document in snapshot!.documents{
                                    print(type(of: document))
                                    let docdata = document.data()
                                    print(type(of: docdata))
                                    print("users data")
                                    print(docdata)
                                    
                                    print("---------------")
                                    for (key, value) in docdata{
                                        print("key is \(key) : value is \(value)")
                                        var newvalue = value as! String
                                        self.details.append(newvalue)
                                        if key == "firstName"{
                                            self.firstName = "First Name : \(newvalue)"
                                            print("printing first name : \(self.firstName)")
                                        }
                                        if key == "lastName"{
                                            self.lastName = "last Name : \(newvalue)"
                                        }
                                        if key == "emailAddress"{
                                            self.emailAddress = "Email Address : \(newvalue)"
                                        }
                                       
                                        
                                        if key == "streetAddress"{
                                            self.streetAddress = "Street Address : \(newvalue)"
                                        }
                                        if key == "city"{
                                            self.city = "City : \(newvalue)"
                                        }
                                        if key == "state"{
                                            self.state = "State : \(newvalue)"
                                        }
                                        if key == "contactNumber"{
                                            self.contactNumber = "Contact Number : \(newvalue)"
                                        }
                                        
                                        if key == "qualification"{
                                            self.qualification = "Qualification : \(newvalue)"
                                        }
                                    }
                                }
                            }
            }
        }else {
          print("Authentication Error")
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Logout"), style: .plain, target: self, action: #selector(userLogOut))
        
        //print("firstName \(firstName)")
        //greetingLabel.text = "Welcome, \(firstName)"
        //
        //reportButtoOutlet.createFloatingActionButton()
    }
    
    @IBAction func unwindToVolunteerHomevView(_ seg: UIStoryboardSegue){
        
    }
    @IBAction func viewReportsClicked(_ sender: UIButton) {
        self.showSpinner()
        Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) { (t) in
            self.removeSpinner()
        }
        performSegue(withIdentifier: "reportsSegue", sender: UIButton.self)
    }
    func generateRoundButtons(){
        chatViewButtonOutlet.layer.cornerRadius = chatViewButtonOutlet.frame.height/2
        chatViewButtonOutlet.clipsToBounds = true
        
        viewReportsBtnOutlet.layer.cornerRadius = viewReportsBtnOutlet.frame.height/2
        viewReportsBtnOutlet.clipsToBounds = true
        
        profileBtnOutlet.layer.cornerRadius = profileBtnOutlet.frame.height/2
        profileBtnOutlet.clipsToBounds = true
        
        reportBtnOutlet.layer.cornerRadius = reportBtnOutlet.frame.height/2
        reportBtnOutlet.clipsToBounds = true
    }
    func generateTabBar(){
        customTabBarView.layer.cornerRadius = customTabBarView.frame.size.height/2
        customTabBarView.clipsToBounds = true
    }
    @objc func userLogOut(){
        unwind()
    }
    
    func unwind(){
        performSegue(withIdentifier: "backToLogin", sender: self)
    }
    
    @IBAction func ChatButtonClicked(_ sender: UIButton) {
        self.showSpinner()
        Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) { (t) in
            self.removeSpinner()
        }
        guard let url = URL(string: "whatsapp://") else { return }
        
        if UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }else{
            let vc = SKStoreProductViewController()
            vc.loadProduct(withParameters: [SKStoreProductParameterITunesItemIdentifier: NSNumber(value: 310633997)], completionBlock: nil)
            present(vc, animated: true)
        }
    }
    
    
    @IBAction func reportClicked(_ sender: UIButton) {
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        self.showSpinner()
        
        let identifier = segue.identifier
        if identifier == "CPRT" {
//            Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) { (t) in
//                self.removeSpinner()
//            }
            let segueDestination = segue.destination as! CreateReportViewController
            segueDestination.username = userName
        }
        
        if identifier == "profileDetails" {
                    let destination = segue.destination as! ProfileViewController
                    print("printing the values of new array")
                    print(detailsUpdated)
                    detailsUpdated.append(firstName)
                    detailsUpdated.append(lastName)
                    detailsUpdated.append(emailAddress)
                    detailsUpdated.append(streetAddress)
                    detailsUpdated.append(city)
                    detailsUpdated.append(state)
                    detailsUpdated.append(contactNumber)
                    detailsUpdated.append(qualification)
                    destination.profile = detailsUpdated
                }
        
//        if identifier == "reportsSegue"{
////            self.showSpinner()
////            Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) { (t) in
////                self.removeSpinner()
////            }
//            let destination = segue.destination as! ReportsViewController
//        }
    }
    
}
