//
//  Spinner.swift
//  CERT
//
//  Created by JayaShankar Mangina on 4/27/22.
//

import Foundation
import UIKit

var spinnerView : UIView?

extension UIViewController {
    func showSpinner(){
        spinnerView = UIView(frame: self.view.bounds)
        spinnerView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = spinnerView!.center
        activityIndicator.startAnimating()
        spinnerView?.addSubview(activityIndicator)
        self.view.addSubview(spinnerView!)
    }
    
    func removeSpinner(){
        spinnerView?.removeFromSuperview()
        spinnerView = nil
    }
}
