//
//  launchScreenViewController.swift
//  CERT
//
//  Created by JayaShankar Mangina on 11/30/21.
//

import UIKit

class launchScreenViewController: UIViewController {
    @IBOutlet weak var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(logoImageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

}
