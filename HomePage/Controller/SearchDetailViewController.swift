//
//  SearchDetailViewController.swift
//  Tang
//
//  Created by JGCM on 16/9/15.
//  Copyright © 2016年 xuanZheJiang. All rights reserved.
//

import UIKit
import WebKit
import SwiftyJSON
class SearchDetailViewController: UIViewController, UIScrollViewDelegate {

    var id: String!
    var wk: WKWebView!;
    var pro: UIProgressView!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData();
        self.view.backgroundColor = UIColor.white;
        self.setupUI();
    }
    
    func setupUI() -> Void {
        self.wk = WKWebView.init(frame: self.view.bounds);
        self.wk.scrollView.delegate = self;
        self.wk.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil);
        self.pro = UIProgressView(frame: CGRect(x: 0, y: 0, width: SCREEN_W, height: 50));
        self.pro.progress = 0.0;
        self.wk.addSubview(self.pro);
        self.view.addSubview(self.wk);
    }
    
    func loadData() -> Void {
        let url = "http://api.dantangapp.com/v2/items/" + id;
        BaseRequest.getWithURL(url, para: nil) { (data, error) in
            //            let str = String.init(data: data!, encoding: NSUTF8StringEncoding);
            //            print(str!);
            let obj = JSON.init(data: data!, options: JSONSerialization.ReadingOptions.mutableContainers);
            let TBurl = obj["data"]["purchase_url"].stringValue;
            DispatchQueue.main.async(execute: {
                self.wk.load(URLRequest.init(url: URL.init(string: TBurl)!));
            })
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") {
            pro.isHidden = wk.estimatedProgress == 1
            pro.setProgress(Float(wk.estimatedProgress), animated: true)
        }
    }
    
    deinit {
        wk.removeObserver(self, forKeyPath: "estimatedProgress");
        wk.scrollView.delegate = nil
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let pan = scrollView.panGestureRecognizer
        let velocity = pan.velocity(in: scrollView).y
        if velocity < -5 {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        } else if velocity > 5 {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
