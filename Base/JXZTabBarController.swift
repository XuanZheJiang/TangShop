//
//  JXZTabBarController.swift
//  Tang
//
//  Created by qianfeng on 2016/8/12.
//  Copyright © 2016年 xuanZheJiang. All rights reserved.
//

import UIKit

class JXZTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isTranslucent = false;
        self.tabBar.tintColor = UIColor.init(red: 242 / 255, green: 80 / 255, blue: 85 / 255, alpha: 1);
        let homePageVC = HomePageViewController();
        let productVC = ProductViewController();
        let categoryVC = CategoryViewController();
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "qqq");
        
        let homePageNC = UINavigationController.init(rootViewController: homePageVC);
        let productNC = UINavigationController.init(rootViewController: productVC);
        let categoryNC = UINavigationController.init(rootViewController: categoryVC);
        let InfoNC = UINavigationController.init(rootViewController: sb);
        
        homePageNC.tabBarItem.title = "首页";
        productNC.tabBarItem.title = "单品";
        categoryNC.tabBarItem.title = "分类";
        InfoNC.tabBarItem.title = "关于";
        
        homePageNC.tabBarItem.image = UIImage.init(named: "TabBar_home_23x23_");
        productNC.tabBarItem.image = UIImage.init(named: "TabBar_gift_23x23_");
        categoryNC.tabBarItem.image = UIImage.init(named: "TabBar_category_23x23_");
        InfoNC.tabBarItem.image = UIImage.init(named: "header");
        InfoNC.tabBarItem.imageInsets = UIEdgeInsetsMake(3, 0, -3, 0);
        
        let controllers = [homePageNC, productNC, categoryNC, InfoNC];
        self.viewControllers = controllers;
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
