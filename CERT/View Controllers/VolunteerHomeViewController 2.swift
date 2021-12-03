//
//  VolunteerHomeViewController.swift
//  CERT
//
//  Created by JayaShankar Mangina on 12/2/21.
//

import UIKit
import FirebaseAuth

class VolunteerHomeViewController: UIViewController {

    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var reportButtoOutlet: UIButton!
    @IBOutlet weak var volunteerImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Volunteer DashBoard"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Logout"), style: .plain, target: self, action: #selector(userLogOut))
        
    }
    
    @objc func userLogOut(){
        let signOutAlertAction = UIAlertAction(title: "Sign Out", style: .destructive) { (action) in
            do{
                try Auth.auth().signOut()
                let logoutVC = LoginViewController()
                let logoutNVC = UINavigationController(rootViewController: logoutVC)
                self.present(logoutNVC, animated: true, completion: nil)
            } catch let err {
                Service.showAlert
            }
        }
        
    }
    
    @IBAction func reportClicked(_ sender: UIButton) {
        let reportVC = storyboard?.instantiateViewController(withIdentifier: "cReport")
        view?.window?.rootViewController = reportVC
        view?.window?.makeKeyAndVisible()
    }
    
}
