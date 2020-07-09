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

class MainTabController: UITabBarController {
    
    lazy var box =  UIView()
    
    
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let color1 = Utils.hexStringToUIColor(hex: "303952")
        configureViewControllers()
        var nav = viewControllers![0] as? UINavigationController
        var feed = nav!.viewControllers.first as? FeedController
        
        view.backgroundColor = color1
        
        tabBar.barTintColor = .black
        
        
        
    }
    
    
    
    func configureViewControllers() {
        let feed = FeedController()
        let nav1 = templateNavigationController(image: UIImage(systemName: "house"), rootViewController: feed)
        
        viewControllers = [nav1]
    }
    
    //MARK: - Helpers
    
    
    func templateNavigationController(image: UIImage?, rootViewController: UIViewController)-> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .black
        nav.navigationBar.prefersLargeTitles = true
        nav.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,]
        nav.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,]
        nav.navigationBar.topItem?.title = "Conduit"
        return nav
    }
    

}

