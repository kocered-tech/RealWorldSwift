//
//  ProfileController.swift
//  RealWorldSwift
//
//  Created by Erdem Koçer on 9.07.2020.
//  Copyright © 2020 Erdem Koçer. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import SDWebImage

class ProfileController: UIViewController {

    let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTA0OTQ0LCJ1c2VybmFtZSI6InNlbGFtaW0iLCJleHAiOjE1OTk0NzY3ODl9.yjEW0wsKeu7yt7D6opwhAPdSGsM8iZEwaUoBfyEk3oA"
    
    var user : User?
    
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        
        
        
        return label
    }()
    
    
    let bioLabel : UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
        
    }()
    
    let profileImage : UIImageView = {
        let image = UIImageView()
        
        image.layer.cornerRadius = 50
        image.layer.masksToBounds = true
        image.layer.borderWidth = 1.5
        image.layer.borderColor = UIColor.white.cgColor
        
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let color1 = Utils.hexStringToUIColor(hex: "303952")
        view.backgroundColor = color1
        navigationController?.navigationBar.topItem?.title = "Profile"
        getCurrentUser()
        
        
        
    }
    
    func configureUI() {
        view.addSubview(profileImage)
        view.addSubview(usernameLabel)
        view.addSubview(bioLabel)
        
        profileImage.sd_setImage(with: URL(string: user!.image))
        usernameLabel.text = user?.username
        bioLabel.text = user?.bio
        
        profileImage.snp.makeConstraints { (make) in
            
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaInsets)
            make.width.height.equalTo(100)
            
        }
        
        usernameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(profileImage.snp.bottom).offset(40)
            make.centerX.equalTo(view)
    
        }
    
        bioLabel.snp.makeConstraints { (make) in
            make.top.equalTo(usernameLabel.snp.bottom).offset(10)
            make.left.equalTo(view.safeAreaInsets)
            make.right.equalTo(view.safeAreaInsets)
            
        }
    
        
        
    }
    
    
    
    func getCurrentUser() {
        let headers = HTTPHeaders([
           HTTPHeader(name: "Authorization", value: String("Token \(token)"))
        ])
        
        AF.request("https://conduit.productionready.io/api/user", method: .get, headers: headers).response { (response) in
            //debugPrint(response)
            let json = response.data
            
            do {
                let decoder = JSONDecoder()
                
                self.user = try decoder.decode(Userbody.self, from: json!).user
                self.configureUI()
                
                

            }
            
            catch {
                print(error)
            }
            
            
        }
    }



}







extension ProfileController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hey")
        return cell!
    }
    
    //
}

extension ProfileController: UITableViewDelegate {
    //
}
