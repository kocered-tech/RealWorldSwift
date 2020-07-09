//
//  AddArticleController.swift
//  RealWorldSwift
//
//  Created by Erdem Koçer on 9.07.2020.
//  Copyright © 2020 Erdem Koçer. All rights reserved.
//

import UIKit
import SnapKit

class AddArticleController: UIViewController, UITextViewDelegate {
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Add an article"
        label.font = .boldSystemFont(ofSize: 32)
        label.textColor = .white
        
        return label
    }()
    
    let addButton: UIButton = {
       let button = UIButton()
        button.setTitle("Publish", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)

        //button.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        
        return button
    }()
    
    
    let titleTextField: UITextView = {
        let textField = UITextView()
        textField.text = "title"
        textField.textColor = .lightGray
        textField.backgroundColor = UIColor(white: 0.5, alpha: 0.1)
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.isScrollEnabled = false
        textField.font = .monospacedSystemFont(ofSize: 16, weight: .light)
        textField.textColor = .white
        textField.autocorrectionType = .no

        
        
        return textField
    }()
    
    let bodyTextField: UITextView = {
        let textField = UITextView()
        textField.textColor = .lightGray
        textField.backgroundColor = UIColor(white: 0.5, alpha: 0.1)
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.isScrollEnabled = false
        textField.font = .monospacedSystemFont(ofSize: 16, weight: .light)
        textField.textColor = .white
        textField.autocorrectionType = .no
        return textField
    }()
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        titleTextField.text = ""
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Utils.hexStringToUIColor(hex: "303952")
        self.titleTextField.delegate = self
        configureUI()
    }
    
    
    func configureUI() {
        view.addSubview(headerLabel)
        view.addSubview(addButton)
        view.addSubview(titleTextField)
        view.addSubview(bodyTextField)
        
        headerLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(view).offset(20)
            
        }
        
        addButton.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.left.equalTo(headerLabel.snp.right).offset(30)
        }
        
        titleTextField.snp.makeConstraints { (make) in
            make.top.equalTo(headerLabel.snp.bottom).offset(20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).inset(20)
        }
        
        bodyTextField.snp.makeConstraints { (make) in
            make.top.equalTo(titleTextField.snp.bottom).offset(40)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).inset(20)
        }
        
        
        
    }

}
