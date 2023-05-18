//
//  CViewController.swift
//  autoLayout_Practice
//
//  Created by 지상률 on 2023/04/28.
//

import Foundation
import UIKit

class CViewController: UIViewController{
    var intArray: [Int] = []
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var completeBtn: RoundedButton!
    @IBOutlet weak var separateLine: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
            
        if intArray[0] == 1{
            self.stackView.removeArrangedSubview(self.stackView.subviews[0])
            self.stackView.subviews[0].removeFromSuperview()
        }
        if intArray[1] == 1{
            self.stackView.removeArrangedSubview(self.stackView.subviews[1])
            self.stackView.subviews[1].removeFromSuperview()
        }
        if intArray[2] == 1{
            self.stackView.removeArrangedSubview(self.stackView.subviews[2])
            self.stackView.subviews[2].removeFromSuperview()
        }
        if intArray[3] == 1{
            self.stackView.removeArrangedSubview(self.stackView.subviews[3])
            self.stackView.subviews[3].removeFromSuperview()
        }
        
        completeBtn.addTarget(self, action: #selector(presentModalController), for: .touchUpInside)
    }

    @objc func presentModalController() {
        dismiss(animated: true) {
            let og = BViewController()
            self.present(og, animated: true, completion: nil)
        }
    }
    
}
