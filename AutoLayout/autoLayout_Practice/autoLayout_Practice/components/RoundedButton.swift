//
//  RoundedButton.swift
//  autoLayout_Practice
//
//  Created by 지상률 on 2023/04/19.
//

import Foundation
import UIKit

@IBDesignable
class RoundedButton: UIButton {
    @IBInspectable
    var borderWidth: CGFloat = 1 {
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = UIColor.init(named: "completebutton")! {
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat = 8 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable
    var hasShadow: Bool = false {
        didSet{
            if hasShadow {
                self.layer.applyShadow()
            }
        }
    }
}
 
