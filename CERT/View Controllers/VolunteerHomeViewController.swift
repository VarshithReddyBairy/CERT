//
//  VolunteerHomeViewController.swift
//  CERT
//
//  Created by JayaShankar Mangina on 2/21/22.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase
class UserDetails{
    
}

class VolunteerHomeViewController: UIViewController {

    var userName : String?
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var reportButtoOutlet: UIButton!
    @IBOutlet weak var volunteerImageView: UIImageView!
    
    var firstName : String?
    var lastName : String?
    var contactNumber : Int?
    var emailAdd : String?
    var address : String?
    var city : String?
    var state : String?
    var qualification : String?
    var details = ["First Name: Vinay", "Last Name : Paspula", "Contact Number : 6602158877" , "EmailId : vinaykmr1490@gmail.com" , "Address : 1115 N College Dr", "City : Maryville", "State : Missouri", "Qualification : CERT Trainee"]
    
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
            Database.database().reference().child("usersDB").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String: AnyObject]{
                    self.firstName = dictionary["firstName"] as? String
                }
                
            }, withCancel: nil)
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
            destination.profile = details
        }
    }
    
}
