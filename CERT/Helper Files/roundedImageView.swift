//
//  roundedImageView.swift
//  CERT
//
//  Created by CERT on 2/20/22.
//

import UIKit

@IBDesignable
class RoundedImageView: UIImageView {
    @IBInspectable var roundedImageView:Bool = false {
        didSet {
            if roundedImageView {
                layer.cornerRadius = frame.height/2
            }
        }
    }
    override func prepareForInterfaceBuilder() {
        if roundedImageView {
            layer.cornerRadius = frame.height/2
        }
    }

}
