//
//  FeedController.swift
//  RealWorldSwift
//
//  Created by Erdem Koçer on 8.07.2020.
//  Copyright © 2020 Erdem Koçer. All rights reserved.
//

import UIKit
import Alamofire

class FeedController: UITableViewController {

    
    var articleArray : [Article] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.backgroundColor = Utils.hexStringToUIColor(hex: "303952")
        view.backgroundColor = Utils.hexStringToUIColor(hex: "303952")
        tableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        tableView.backgroundColor = .clear
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
//        cell.textLabel!.text = articleArray[indexPath.row].body
//        print(articleArray[indexPath.row].author)
//        // Configure the cell...
//        cell.backgroundColor = .black
//        cell.textLabel?.textColor = .white
        cell.post = articleArray[indexPath.row]
        cell.backgroundColor = .clear
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func parseJson() {
        AF.request("https://conduit.productionready.io/api/articles").response { (response) in
            let json = response.data
            
            do {
                let decoder = JSONDecoder()
                
                let articles = try decoder.decode(Welcome.self, from: json!)
                
                self.articleArray = articles.articles
                self.tableView.reloadData()
                
                

            }
            
            catch {
                print(error)
            }
            
            
        }
    }

}
