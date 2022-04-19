//
//  floatingActionButton.swift
//  CERT
//
//  Created by CERT on 2/20/22.
//

import UIKit

extension UIButton{
    func createFloatingActionButton(){
        backgroundColor = .black
        layer.shadowOpacity  = 0.35
        layer.shadowRadius  = 10
        layer.shadowOffset = CGSize(width: 0, height: 10)
    }
}

