//
//  JXDetailViewController.swift
//  Tang
//
//  Created by JGCM on 16/8/16.
//  Copyright © 2016年 xuanZheJiang. All rights reserved.
//

import UIKit
import WebKit

class JXDetailViewController: UIViewController, UIScrollViewDelegate {

    var wk: WKWebView!;
    var url: String!;
    var coverUrl: String!;
    var titleL: String!;
    var shareMsg: String!;
    let imageView = UIImageView.init();
    var pro: UIProgressView!;
    let copyjxz = NotificationCenter.default;

    
    func copyUrl() -> Void {
        XZAlertView.addXZAlertView(self.wk, title: "已复制到粘贴板");
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        copyjxz.addObserver(self, selector: #selector(self.copyUrl), name: NSNotification.Name(rawValue: "copy"), object: nil);
        imageView.sd_setImage(with: URL.init(string: self.coverUrl)!);
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.action, target: self, action: #selector(self.share));
        
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
//        copyjxz.removeObserver(self, forKeyPath: "copy");
        wk.scrollView.delegate = nil
    }
    
    func share() -> Void {
//        let screenShot = self.view.snapshotViewAfterScreenUpdates(true);
//        let screenShot = UIScreen.main.snapshotView(afterScreenUpdates: true);
        let GSVC = GSViewController();
        GSVC.modalTransitionStyle = .crossDissolve
        GSVC.coverUrl = self.coverUrl;
        GSVC.shareMsg = self.shareMsg;
        GSVC.url = self.url;
        GSVC.titleL = self.titleL;
//        GSVC.GSView = screenShot;
        let image = self.screenView(self.view);
        let screenShot = UIImageView(image: image);
        GSVC.GSView = screenShot;
        self.present(GSVC, animated: true, completion: nil);
    }
    
    func screenView(_ view: UIView) -> UIImage {
        let rect = view.frame
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        self.navigationController?.view.layer.render(in: context!);
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
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
