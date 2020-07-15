//
//  AddArticleController.swift
//  RealWorldSwift
//
//  Created by Erdem Koçer on 9.07.2020.
//  Copyright © 2020 Erdem Koçer. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import Spinners

class AddArticleController: UIViewController, UITextViewDelegate {
    let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTA0OTQ0LCJ1c2VybmFtZSI6InNlbGFtaW0iLCJleHAiOjE1OTk0NzY3ODl9.yjEW0wsKeu7yt7D6opwhAPdSGsM8iZEwaUoBfyEk3oA"
    var spinners: Spinners!
    
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
        button.addTarget(self, action: #selector(createArticle), for: .touchUpInside)
        return button
    }()
    
    
    let titleTextField: UITextView = {
        let textField = UITextView()
        textField.text = "title"
        textField.tag = 0
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
    
    let descriptionTextField: UITextView = {
        let textField = UITextView()
        textField.tag = 1
        textField.textColor = .lightGray
        textField.text = "description"
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
        textField.tag = 2
        textField.text = "body"
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
    
    let tagsTextField: UITextView = {
        let textField = UITextView()
        textField.text = "tags (seperate by spaces)"
        textField.tag = 3
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
        
        textView.text = ""
        
        
        
        
    }
    func textViewDidChange(_ textView: UITextView) {
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.tag == 0 {
            if textView.text == "" {
                textView.text = "title"
            }
        }
        
        if textView.tag == 1 {
            if textView.text == "" {
                textView.text = "description"
            }
        }
        
        if textView.tag == 2 {
            if textView.text == "" {
                textView.text = "body"
            }
        }
        
        if textView.tag == 3 {
            if textView.text == "" {
                textView.text = "tags (seperate by spaces)"
            }
        }
    }
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Utils.hexStringToUIColor(hex: "303952")
        self.titleTextField.delegate = self
        self.descriptionTextField.delegate = self
        self.bodyTextField.delegate = self
        self.tagsTextField.delegate = self
        configureUI()
        spinners = Spinners(type: .wheel, with: self)
    }
    
    //MARK: - Fetch Functions
    
    @objc func createArticle() {

        spinners.present()
        let parameters = ["article": [
            "title": titleTextField.text ?? "",
            "description": descriptionTextField.text ?? "",
            "body": bodyTextField.text ?? "",
            "tagList": tagsTextField.text.components(separatedBy: " ")
            ]
        ]
        let headers = HTTPHeaders([
           HTTPHeader(name: "Authorization", value: String("Token \(token)"))
        ])
        
        AF.request("https://conduit.productionready.io/api/articles", method: .post, parameters: parameters, headers: headers).response { (response) in
            debugPrint(response)
            self.dismiss(animated: true, completion: nil)
            
            
        }
        spinners.dismiss()
    }
    
    
    //MARK: - UI
    
    
    
    func configureUI() {
        view.addSubview(headerLabel)
        view.addSubview(addButton)
        view.addSubview(titleTextField)
        view.addSubview(descriptionTextField)
        view.addSubview(bodyTextField)
        view.addSubview(tagsTextField)
        
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
        
        descriptionTextField.snp.makeConstraints { (make) in
            make.top.equalTo(titleTextField.snp.bottom).offset(40)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).inset(20)
        }
        
        bodyTextField.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionTextField.snp.bottom).offset(40)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).inset(20)
            make.height.greaterThanOrEqualTo(200)
        }
        
        tagsTextField.snp.makeConstraints { (make) in
            make.top.equalTo(bodyTextField.snp.bottom).offset(40)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).inset(20)
        }
        
        
    }
    
    


}
