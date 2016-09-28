//
//  HomePageViewController.swift
//  Tang
//
//  Created by JGCM on 16/8/15.
//  Copyright © 2016年 xuanZheJiang. All rights reserved.
//

import UIKit
import MJRefresh

class HomePageViewController: UIViewController, UIScrollViewDelegate {

    var scrollView = UIScrollView();
    var sliderView: UIView!;
    var j = 0;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.hideBottomHairline()
        navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 242 / 255, green: 80 / 255, blue: 85 / 255, alpha: 1);
        self.automaticallyAdjustsScrollViewInsets = false;
        self.navigationItem.title = "首页";
        navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .plain, target: nil, action: nil);
//        let imageView = UIImageView(image: UIImage(named: "header"));
//        self.navigationItem.titleView = imageView;
//        self.navigationController?.navigationBar.titleTextAttributes = {[NSFontAttributeName: UIFont.systemFontOfSize(18),NSForegroundColorAttributeName: UIColor.whiteColor()]}();
        self.navigationController?.navigationBar.isTranslucent = false;
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(self.search));
        self.createUI();
        self.createTopView();
    }
    
    func search() -> Void {
        let searchVC = SearchViewController();
        searchVC.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(searchVC, animated: true);
    }
    
    func createTopView() -> Void {
        let topView = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_W, height: 30));
        topView.backgroundColor = UIColor.white;
        self.view.addSubview(topView);
        let nameArr = ["精选", "美食", "家居", "数码", "美物", "杂货"];
        let btnW = CGFloat((SCREEN_W - 7 * 20) / 6);
        let btnH = CGFloat(30);
        sliderView = UIView.init(frame: CGRect(x: 20, y: 28, width: btnW, height: 2));
        sliderView.backgroundColor = BASE_COLOR;
        topView.addSubview(sliderView);
        var i = 0;
        for _ in 1...6 {
            let button = UIButton();
            button.frame = CGRect(x: CGFloat(i % 6) * (btnW + 20) + 20, y: 0, width: btnW, height: btnH)
//            button.titleLabel?.font = UIFont.init(name: "Helvetica-Light", size: 14);
            button.setTitle(nameArr[i], for: UIControlState());
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight);
            if i == 0 {
                button.setTitleColor(BASE_COLOR, for: UIControlState());
            } else {
                button.setTitleColor(UIColor.black, for: UIControlState());
            }
            button.addTarget(self, action: #selector(self.btnAction(_:)), for: UIControlEvents.touchUpInside);
            button.tag = 100 + i;
            topView.addSubview(button);
            i += 1;
        }
        
    }
    //标签条按钮点击事件
    func btnAction(_ button: UIButton) -> Void {
        self.colorAction(button);
        self.scrollView.setContentOffset(CGPoint(x: SCREEN_W * CGFloat(button.tag - 100), y: 0), animated: true);
        
    }
    
    func colorAction(_ button: UIButton) -> Void {
        for i in 0...5 {
            let preBtn = self.view.viewWithTag(100 + i) as! UIButton
            preBtn.setTitleColor(UIColor.black, for: UIControlState());
        }
        button.setTitleColor(BASE_COLOR, for: UIControlState());
        UIView.animate(withDuration: 0.25, animations: {
            self.sliderView.mj_x = button.mj_x;
        }) 
    }
    
    func createUI() -> Void{
        let JXVC = JingXuanViewController();
        JXVC.view.frame = CGRect(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H);
        let FVC = FoodViewController();
        FVC.view.frame = CGRect(x: SCREEN_W, y: 0, width: SCREEN_W, height: SCREEN_H);
        let HVC = HouseViewController();
        HVC.view.frame = CGRect(x: SCREEN_W * 2, y: 0, width: SCREEN_W, height: SCREEN_H);
        let DVC = DigitalViewController();
        DVC.view.frame = CGRect(x: SCREEN_W * 3, y: 0, width: SCREEN_W, height: SCREEN_H);
        let NVC = NiceViewController();
        NVC.view.frame = CGRect(x: SCREEN_W * 4, y: 0, width: SCREEN_W, height: SCREEN_H);
        let GVC = GeneralViewController();
        GVC.view.frame = CGRect(x: SCREEN_W * 5, y: 0, width: SCREEN_W, height: SCREEN_H);
        
        
        let controllers = [JXVC, FVC, HVC, DVC, NVC, GVC];
        for vc in controllers {
            self.addChildViewController(vc);
        }
        scrollView.isPagingEnabled = true;
        scrollView.bounces = false;
        scrollView.delegate = self;
        scrollView.frame = CGRect(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H);
        scrollView.contentSize = CGSize(width: SCREEN_W * 6, height: SCREEN_H);
        for VC in childViewControllers {
            scrollView.addSubview(VC.view);
        }
        self.view.insertSubview(scrollView, at: 0);
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        for i in 0...5 {
            let preBtn = self.view.viewWithTag(100 + i) as! UIButton
            preBtn.setTitleColor(UIColor.black, for: UIControlState());
        }
        
        let a: Int = Int(scrollView.contentOffset.x / SCREEN_W);
        let buttonj = self.view.viewWithTag(j + 100) as! UIButton;
        buttonj.setTitleColor(UIColor.black, for: UIControlState());
        let button = self.view.viewWithTag(a + 100) as! UIButton;
        button.setTitleColor(BASE_COLOR, for: UIControlState());
        UIView.animate(withDuration: 0.25, animations: {
            self.sliderView.mj_x = button.mj_x;
        }) 
        j = a;
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
