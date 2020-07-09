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
    
//    let addButton : UIButton  = {
//        let button = UIButton()
//        button.imageView?.image = UIImage(systemName: "plus")
//        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        //button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
//
//        return button
//    }()
    
    
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let color1 = Utils.hexStringToUIColor(hex: "303952")
        configureViewControllers()
        var nav = viewControllers![0] as? UINavigationController
        var feed = nav!.viewControllers.first as? FeedController
        
        view.backgroundColor = color1
        
        tabBar.barTintColor = .black
//        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: #selector(addButtonTapped))
        
        //self.navigationItem.rightBarButtonItem = addButton
        
        
        
        
    }
    
    @objc func addButtonTapped() {
        let vc = AddArticleController()
        vc.modalPresentationStyle = .popover
        present(vc, animated: true, completion: nil)
        
    }
    
    
    
    func configureViewControllers() {
        let feed = FeedController()
        let nav1 = templateNavigationController(image: UIImage(systemName: "house"), rootViewController: feed)
        
        let profile = ProfileController()
        let nav2 = templateNavigationController(image: UIImage(systemName: "person"), rootViewController: profile)
        
        viewControllers = [nav1, nav2]
        
    }
    
    //MARK: - Helpers
    
    
    func templateNavigationController(image: UIImage?, rootViewController: UIViewController)-> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image?.withTintColor(.white)
    
        
        nav.navigationBar.barTintColor = .black
        nav.navigationBar.tintColor = .white
        nav.navigationBar.prefersLargeTitles = true
        nav.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,]
        nav.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,]
        nav.navigationBar.topItem?.title = "Conduit"
        let item = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
//        nav.navigationBar.setItems([item], animated: true)
        
        nav.navigationBar.topItem?.rightBarButtonItem = item
        return nav
    }
    

}

