//
//  CategoryViewController.swift
//  Tang
//
//  Created by JGCM on 16/8/14.
//  Copyright © 2016年 xuanZheJiang. All rights reserved.
//  分类界面

import UIKit

class CategoryViewController: UIViewController, CategoryDelegate, MidViewDelegate {
    
    /// 懒加载scrollView
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H));
        scrollView.isScrollEnabled = true;
        scrollView.backgroundColor = UIColor.init(white: 0.95, alpha: 1);
        return scrollView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .plain, target: nil, action: nil);
        self.navigationController?.navigationBar.isTranslucent = false;
        self.automaticallyAdjustsScrollViewInsets = false;
        self.navigationItem.title = "分类";
//        let imageView = UIImageView(image: UIImage(named: "header"));
//        self.navigationItem.titleView = imageView;        
        self.view.addSubview(scrollView);
        self.createUI();
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(self.search));
        
    }
    

    func search() -> Void {
        let searchVC = SearchViewController();
        searchVC.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(searchVC, animated: true);
    }



    func createUI() -> Void {
        
        let topView = CategoryTopViewController();
        self.addChildViewController(topView);
        
        let topBGView = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_W, height: 135));
        let headerVC = childViewControllers[0];
        topBGView.addSubview(headerVC.view);
        
        let bottomView = CategoryBottomView();
        bottomView.frame = CGRect(x: 0, y: 150, width: SCREEN_W, height: 100);
        bottomView.delegate = self;
        let midView = CategoryMidView();
        midView.frame = CGRect(x: 0, y: bottomView.mj_y + bottomView.bottomVieHieght() + 16, width: SCREEN_W, height: SCREEN_H);
        midView.delegate = self;
        self.scrollView.contentSize = CGSize(width: SCREEN_W, height: SCREEN_H + 64);
        self.scrollView.addSubview(midView);
        self.scrollView.addSubview(bottomView);
        self.scrollView.addSubview(topBGView);
        self.scrollView.showsVerticalScrollIndicator = false;
    }
    
    
    func push(_ button: UIButton) {
        let CMDVC = CategoryMidDetailViewController();
        CMDVC.id = button.tag;
        CMDVC.navigationItem.title = button.titleLabel?.text!;
        CMDVC.hidesBottomBarWhenPushed = true;
        self.navigationController!.pushViewController(CMDVC, animated: true);
    }
    
    func pushM(_ tag: UIButton) {
        let CMDVC = CategoryMidDetailViewController();
        CMDVC.id = tag.tag;
        CMDVC.navigationItem.title = tag.titleLabel?.text!;
        CMDVC.hidesBottomBarWhenPushed = true;
        self.navigationController!.pushViewController(CMDVC, animated: true);
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
