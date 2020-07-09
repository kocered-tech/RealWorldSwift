//
//  FeedController.swift
//  RealWorldSwift
//
//  Created by Erdem Koçer on 8.07.2020.
//  Copyright © 2020 Erdem Koçer. All rights reserved.
//

import UIKit
import Alamofire

protocol FeedControllerDelegate {
    func didFavorite(index: Int)
}

class FeedController: UITableViewController {
    var delegate : FeedControllerDelegate?
    
    let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTA0OTQ0LCJ1c2VybmFtZSI6InNlbGFtaW0iLCJleHAiOjE1OTk0NzY3ODl9.yjEW0wsKeu7yt7D6opwhAPdSGsM8iZEwaUoBfyEk3oA"
    
    var user : User?
    //var refreshControl = UIRefreshControl()
    let myrefresh = UIRefreshControl()
    var articleArray : [Article] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        //tableView.backgroundColor = Utils.hexStringToUIColor(hex: "303952")
        view.backgroundColor = Utils.hexStringToUIColor(hex: "303952")
        tableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        
        
        tableView.addSubview(myrefresh)
        myrefresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)

        //fetchUser()
        logInUser()
        
        getCurrentUser()
        //updateuser()
        parseJson()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articleArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        
        cell.post = articleArray[indexPath.row]
        cell.backgroundColor = .clear
        
        return cell
    }
    @objc func refreshData() {
        parseJson()
    }
    
    
    func logInUser() {
        
        let parameters = ["user": [
            "email": "e@k.com",
            "password": "123123123"]]
        AF.request("https://conduit.productionready.io/api/users/login",method: .post,parameters: parameters, encoder: JSONParameterEncoder.default).responseJSON { (response) in
            //debugPrint(response)
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
                

            }
            
            catch {
                print(error)
            }
            
            
        }
    }
    
    func updateuser() {
        
        let parameters = ["user":
        [
            "email":"ellibes@elli.com",
            "bio": "I like to skateboard",
            "image":"https://i.stack.imgur.com/xHWG8.jpg"
            ]
        ]
        let headers = HTTPHeaders([
           HTTPHeader(name: "Authorization", value: String("Token \(token)"))
        ])
         
        AF.request("https://conduit.productionready.io/api/user" ,method: .put,parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).responseJSON { (response) in
            debugPrint(response)
        }
    }
    
    func parseJson() {
        let headers = HTTPHeaders([
           HTTPHeader(name: "Authorization", value: String("Token \(token)"))
        ])
        AF.request("https://conduit.productionready.io/api/articles",headers: headers).response { (response) in
            let json = response.data
            do {
                let decoder = JSONDecoder()
                if let json = json {
                    let articles = try decoder.decode(Welcome.self, from: json)
                    
                    self.articleArray = articles.articles
                    self.tableView.reloadData()
                    DispatchQueue.main.async {
                        self.myrefresh.endRefreshing()
                    }
                }
                
                

            }
            
            catch {
                print(error)
            }
            
            
        }
    }
    
    func fetchUser() {
        let parameters = ["user":
        [
            "username": "selamim",
            "email": "e@k.com",
            "password": "123123123"
        ]
    ]
        
        AF.request("https://conduit.productionready.io/api/users", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: nil).responseJSON { (response) in
            print(response)
        }
        }
    }


