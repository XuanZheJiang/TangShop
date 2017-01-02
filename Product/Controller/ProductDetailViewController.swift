//
//  ProductDetailViewController.swift
//  Tang
//
//  Created by JGCM on 16/8/16.
//  Copyright © 2016年 xuanZheJiang. All rights reserved.
//

import UIKit
import WebKit

class ProductDetailViewController: UIViewController, UIScrollViewDelegate {

    var wk: WKWebView!;
    var url: String!;
    var pro: UIProgressView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wk = WKWebView.init(frame: self.view.bounds);
        wk.scrollView.delegate = self;
        let request = URLRequest.init(url: URL.init(string: url)!);
        wk.load(request);
        
        pro = UIProgressView(frame: CGRect(x: 0, y: 0, width: SCREEN_W, height: 50));
        pro.progress = 0.0;
        wk.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil);
        wk.addSubview(pro);
        self.view.addSubview(wk);
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
