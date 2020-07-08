//
//  ViewController.swift
//  RealWorldSwift
//
//  Created by Erdem Koçer on 8.07.2020.
//  Copyright © 2020 Erdem Koçer. All rights reserved.
//

import UIKit
import Alamofire
import SnapKit

class MainFeedController: UIViewController {
    
    lazy var box =  UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        AF.request("https://conduit.productionready.io/api/articles").response { (data) in
            debugPrint(data)
        }
        
        
    }


}

