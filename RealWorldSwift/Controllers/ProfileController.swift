//
//  ProfileController.swift
//  RealWorldSwift
//
//  Created by Erdem Koçer on 9.07.2020.
//  Copyright © 2020 Erdem Koçer. All rights reserved.
//

import UIKit
import SnapKit

class ProfileController: UIViewController {

    let userToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTA0OTQ0LCJ1c2VybmFtZSI6InNlbGFtaW0iLCJleHAiOjE1OTk0NzY3ODl9.yjEW0wsKeu7yt7D6opwhAPdSGsM8iZEwaUoBfyEk3oA"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let color1 = Utils.hexStringToUIColor(hex: "303952")
        view.backgroundColor = color1
        navigationController?.navigationBar.topItem?.title = "Profile"
        
        
        
        
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
