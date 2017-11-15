//
//  BaseTabBarController.swift
//  斗鱼直播
//
//  Created by mengxuanlong on 17/6/15.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewControllers()
        

    }
    fileprivate func addChildViewControllers(){
        setupChildViewController("首页", image: "menu_homepage_nor", selectedImage: "menu_homepage_sel", controller: HomeViewController.init())
        setupChildViewController("直播", image: "menu_youxi_nor", selectedImage: "menu_youxi_sel", controller: LiveViewController.init())
        setupChildViewController("我的", image: "menu_mine_nor", selectedImage: "menu_mine_sel", controller: MineViewController.init())
        
    }
    fileprivate func setupChildViewController(_ title: String, image: String, selectedImage: String, controller: UIViewController){
        controller.tabBarItem.title = title;
        controller.title = title;
        controller.view.backgroundColor = UIColor.white
        controller.tabBarItem.image = UIImage(named: image)
        controller.tabBarItem.selectedImage = UIImage(named: selectedImage)
        let nav = BaseNavController.init(rootViewController: controller)
        
        addChildViewController(nav)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

