//
//  BViewController.swift
//  autoLayout_Practice
//
//  Created by 지상률 on 2023/04/19.
//

import Foundation
import UIKit

class BViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate{

    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var thirdTextView: UITextView!
    @IBOutlet weak var forthTextField: UITextField!
    
    @IBOutlet weak var firstView: RoundedView!
    @IBOutlet weak var secondView: RoundedView!
    @IBOutlet weak var thirdView: RoundedView!
    @IBOutlet weak var forthView: RoundedView!
    
    @IBOutlet weak var webStackView: UIStackView!
    
    @IBOutlet weak var warningLabel: UILabel!
    
    @IBOutlet weak var firstCountLabel: UILabel!
    @IBOutlet weak var secoundCountLabel: UILabel!
    @IBOutlet weak var thirdCountLabel: UILabel!
    
    @IBOutlet weak var completeBtn: RoundedButton!
    @IBOutlet weak var addWeb: UIButton!
    
    @IBAction func addButton(_ sender: Any) {
        let nextEntryIdx = webStackView.arrangedSubviews.count
        if (nextEntryIdx < 4){
            warningLabel.textColor = .white
            let newStack = createEntry()
            webStackView.insertArrangedSubview(newStack, at: nextEntryIdx)
        }else{
            warningLabel.textColor = .red
        }
    }
    let maxLength1 = 20
    let maxLength2 = 20
    let maxLength3 = 1000
    var webView: [RoundedView] = []
    var webTextField: [UITextField] = []
    
    func createEntry()-> UIView{
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 8
        
        let view = RoundedView()
        view.borderColor = UIColor.init(named: "border") ?? .gray
        view.cornerRadius = 8
        view.borderWidth = 1
        
        let buttonView = RoundedButton()
        buttonView.borderColor = UIColor.init(named: "border") ?? .gray
        buttonView.borderWidth = 1
        buttonView.cornerRadius = 8
        
        
        let textfield = UITextField()
        textfield.font = .systemFont(ofSize: 14)
        textfield.font = UIFont(name: "NanumGothic", size: 14)
        textfield.attributedPlaceholder = NSAttributedString(string: "SNS 또는 홈페이지를 연결해주세요.")
        textfield.delegate = self
        
        textfield.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textfield)
        NSLayoutConstraint.activate([
            textfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            view.trailingAnchor.constraint(equalTo: textfield.trailingAnchor, constant: 16),
            textfield.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            view.bottomAnchor.constraint(equalTo: textfield.bottomAnchor, constant: 16)
        ])
        webView.append(view)
        webTextField.append(textfield)
        
        let deleteButton = UIButton()
        deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        buttonView.addSubview(deleteButton)
        NSLayoutConstraint.activate([
            deleteButton.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor, constant: 14),
            buttonView.trailingAnchor.constraint(equalTo: deleteButton.trailingAnchor, constant: 14),
            deleteButton.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 7),
            buttonView.bottomAnchor.constraint(equalTo: deleteButton.bottomAnchor, constant: 7)
        ])
        deleteButton.addTarget(self, action: #selector(deleteWebSite), for: .touchUpInside)
        
        stack.addArrangedSubview(view)
        stack.addArrangedSubview(buttonView)
        return stack
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        firstTextField.delegate = self
        secondTextField.delegate = self
        thirdTextView.delegate = self
        forthTextField.delegate = self
        updateCharacterCountLabel()

        completeBtn.addTarget(self, action: #selector(presentModalController), for: .touchUpInside)
    }
    
    @objc func presentModalController() {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "CViewController") as? CViewController else {return}
        nextVC.modalPresentationStyle = .overCurrentContext
        if firstTextField.text?.isEmpty == false{
            nextVC.intArray.append(1)
        }else{
            nextVC.intArray.append(0)
        }
        if secondTextField.text?.isEmpty == false{
            nextVC.intArray.append(1)
        }else{
            nextVC.intArray.append(0)
        }
        if thirdTextView.text?.isEmpty == true || temp == 0{
            nextVC.intArray.append(0)
        }else{
            nextVC.intArray.append(1)
        }
        if forthTextField.text?.isEmpty == false{
            nextVC.intArray.append(1)
        }else{
            nextVC.intArray.append(0)
        }
        print(#fileID, #function, #line)
        self.present(nextVC, animated: true)
    }
    
    
    func updateCharacterCountLabel() {
        firstCountLabel.text = "0 / \(maxLength1)" 
        secoundCountLabel.text = "0 / \(maxLength2)"
        thirdCountLabel.text = "0 / \(maxLength3)"
        thirdTextView.text = "다른 사람에게 나를 소개할 수 있도록  자신의 활동을 자세하게 적어주세요."
        thirdTextView.textColor = .placeholderText
    }
    
    @objc func deleteWebSite(sender: UIButton!){
        self.webStackView.removeArrangedSubview((sender.superview?.superview)!)
        sender.superview?.superview?.removeFromSuperview()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentCount = textField.text?.count ?? 0
        
        let maxLenght = 20
        
        if (textField == firstTextField){
            firstCountLabel.text = "\(currentCount) / \(maxLenght)"
        }else{
            secoundCountLabel.text = "\(currentCount) / \(maxLenght)"
        }
        
        let availableCount = maxLenght - currentCount
        
        let replaceCount = string.count
        
        if (replaceCount > availableCount){
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case firstTextField:
            firstView.layer.borderColor = UIColor.blue.cgColor
        case secondTextField:
            secondView.layer.borderColor = UIColor.blue.cgColor
        case forthTextField:
            forthView.layer.borderColor = UIColor.blue.cgColor
        case webTextField[0]:
            webView[0].layer.borderColor = UIColor.blue.cgColor
        default:
            webView[1].layer.borderColor = UIColor.blue.cgColor
        }
    }
   
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case firstTextField:
            firstView.borderColor = UIColor.init(named: "border") ?? .lightGray
        case secondTextField:
            secondView.borderColor = UIColor.init(named: "border") ?? .lightGray
        case forthTextField:
            forthView.borderColor = UIColor.init(named: "border") ?? .lightGray
        case webTextField[0]:
            webView[0].borderColor = UIColor.init(named: "border") ?? .lightGray
        default:
            webView[1].borderColor = UIColor.init(named: "border") ?? .lightGray
        }
    }
    
    var temp = 0
    func textViewDidBeginEditing(_ textView: UITextView) {
        temp += 1
        if thirdTextView.textColor == .placeholderText{
            thirdTextView.text = nil
            thirdTextView.textColor = .black
        }
        thirdView.layer.borderColor = UIColor.blue.cgColor
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        thirdView.borderColor = UIColor.init(named: "border") ?? .lightGray
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentCount = textView.text?.count ?? 0
        
        let maxLenght = 1000
        if (textView == thirdTextView){
            thirdCountLabel.text = "\(currentCount) / \(maxLenght)"

        }
        let availableCount = maxLenght - currentCount
        
        let replaceCount = text.count
        
        if (replaceCount > availableCount){
            return false
        }
        return true
    }
}
