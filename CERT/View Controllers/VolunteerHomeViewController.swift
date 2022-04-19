//
//  VolunteerHomeViewController.swift
//  CERT
//
//  Created by CERT on 2/21/22.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase



class VolunteerHomeViewController: UIViewController {

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
    var userName : String?
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var reportButtoOutlet: UIButton!
    @IBOutlet weak var volunteerImageView: UIImageView!
    
   
//    var details = ["First Name: Vinay", "Last Name : Paspula", "Contact Number : 6602158877" , "EmailId : vinaykmr1490@gmail.com" , "Address : 1115 N College Dr", "City : Maryville", "State : Missouri", "Qualification : CERT Trainee"]
//
    
    var details :  [ String] = []
    var detailsUpdated : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = ""
        if Auth.auth().currentUser != nil {
            userName = Auth.auth().currentUser?.email
            greetingLabel.text = "Welcome, "+userName!
            let uid = Auth.auth().currentUser?.uid
            print("uid : \(uid!)")
//            Database.database().reference().child("usersDB").child(uid!).observe(.value, with: { (snapshot) in
//                if let dictionary = snapshot.value as? [String: AnyObject]{
//                    self.firstName = dictionary["firstName"] as? String
//                }
//            }, withCancel: nil)
//            Database.database().reference().child("usersDB").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
//                if let dictionary = snapshot.value as? [String: AnyObject]{
//                    self.firstName = dictionary["firstName"] as? String
//                }
//
//            }, withCancel: nil)
//
//            Database.database().reference().child("reportsDB").observeSingleEvent(of: .value, with: { (snapshot) in
//                print("Reports are")
//                    print(snapshot)
//                }
//
//        },withCancel: nil)
            let db = Firestore.firestore()
//            db.collection("reportsDB").getDocuments{(snapshot ,error) in
//                if error == nil {
//                    for document in snapshot!.documents{
//                        let docdata = document.data()
//                        print("reports data")
//                        print(docdata)
//                    }
//                }
//            }
            
            db.collection("usersDB").whereField("emailAddress", isEqualTo: userName).getDocuments{(snapshot ,error) in
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
            
            
           
            
            
//            db.collection("cities").whereField("capital", isEqualTo: true)
//                .getDocuments() { (querySnapshot, err) in
//                    if let err = err {
//                        print("Error getting documents: \(err)")
//                    } else {
//                        for document in querySnapshot!.documents {
//                            print("\(document.documentID) => \(document.data())")
//                        }
//                    }
//            }

        } else {
          print("Authentication Error")
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Logout"), style: .plain, target: self, action: #selector(userLogOut))
        
        //print("firstName \(firstName)")
        //greetingLabel.text = "Welcome, \(firstName)"
        //
        
        
        reportButtoOutlet.createFloatingActionButton()
        
        
      
    }
    

    @objc func userLogOut(){
        unwind()
    }
    
    func unwind(){
        performSegue(withIdentifier: "unWindToHome", sender: self)
    }
    
    
    @IBAction func reportClicked(_ sender: UIButton) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier
        if identifier == "CPRT" {
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
    }
    
}
