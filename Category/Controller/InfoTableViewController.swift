//
//  InfoTableViewController.swift
//  Tang
//
//  Created by JGCM on 16/8/25.
//  Copyright © 2016年 xuanZheJiang. All rights reserved.
//

import UIKit
import MessageUI
import SafariServices
import UnityAds

class InfoTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var sizeL: UILabel!
    
    @IBOutlet weak var unityAds: UITableViewCell! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.showUnityAds))
            unityAds.addGestureRecognizer(tap)
        }
    }
    
    func showUnityAds() {
        UnityAds.show(self, placementId: "rewardedVideo")
    }
    
    
    @IBOutlet weak var picView: UIImageView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.cusScale))
            picView.addGestureRecognizer(tap)
        }
    }
    
    func cusScale() -> Void {
        let ani = CAKeyframeAnimation()
        ani.keyPath = "transform.scale"
        let value1 = NSValue(cgPoint: CGPoint(x: 2, y: 2))
        let value2 = NSValue(cgPoint: CGPoint(x: 3, y: 3))
        let value4 = NSValue(cgPoint: CGPoint(x: 1, y: 1))
        let value5 = NSValue(cgPoint: CGPoint(x: 1.3, y: 1.3))
        let value6 = NSValue(cgPoint: CGPoint(x: 1, y: 1))
        let values = [value1, value2, value4, value5, value6]
        ani.values = values
        ani.duration = 0.7
        self.picView.layer.add(ani, forKey: "")
    }
    @IBOutlet weak var Advice: UITableViewCell! {
        didSet {
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.emailAction));
            Advice.addGestureRecognizer(tap);
        }
    }
    
    func emailAction() -> Void {
        // 首先要判断设备具不具备发送邮件功能
        if MFMailComposeViewController.canSendMail() {
            let controller = MFMailComposeViewController()
            controller.setSubject("糖购JGCM问题反馈")
            controller.mailComposeDelegate = self
            controller.setToRecipients(["jgcm@live.cn"])
            controller.setMessageBody("\(versionL.text!)", isHTML: false)
            self.present(controller, animated: true, completion: nil)
        } else {
            let alert = UIAlertController.init(title: "打开邮箱失败", message: "未设置邮箱账户", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "确定", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    @IBOutlet weak var CallMe: UITableViewCell! {
        didSet {
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.callMe));
            CallMe.addGestureRecognizer(tap);
        }
    }
    
    func callMe() -> Void {
        
        if #available(iOS 9.0, *) {
            let url = URL(string: "https://xuanzhejiang.github.io");
            let safari = SFSafariViewController.init(url: url!, entersReaderIfAvailable: true);
            self.present(safari, animated: true, completion: nil);
        } else {
            let callMeVC = CallMeViewController();
            callMeVC.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(callMeVC, animated: true);
        };
        
    }
    
    
    
    
    //评价app
    @IBOutlet weak var Evaluate: UIView! {
        didSet {
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.evaluateAction));
            Evaluate.addGestureRecognizer(tap);
        }
    }
    
    func evaluateAction() -> Void {
            let url = "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1145725777"
            UIApplication.shared.openURL(URL.init(string: url)!)
        
    }
    
    @IBOutlet weak var Copyright: UIView! {
        didSet {
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.copyrightAction));
            Copyright.addGestureRecognizer(tap);
        }
    }
    
    func copyrightAction() -> Void {
        let CPVC = CopyrightViewController();
        CPVC.navigationItem.title = "版权声明";
        CPVC.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(CPVC, animated: true);
    }
    
    @IBOutlet weak var CleanCache: UITableViewCell! {
        didSet {
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.clean));
            CleanCache.addGestureRecognizer(tap);
        }
    }
    //清除缓存文件方法
    func clean() -> Void {
        let message = String(self.fileSizeOfCache()) + "MB";
        let alert = UIAlertController.init(title: "清除缓存", message: message, preferredStyle: UIAlertControllerStyle.alert);
        let cancle = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel) { (cancle) in
        }
        let action = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.destructive) { (action) in
            
            // 取出cache文件夹目录 缓存文件都在这个目录下
            let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
            
            // 取出文件夹下所有文件数组
            let fileArr = FileManager.default.subpaths(atPath: cachePath!)
            
            // 遍历删除
            for file in fileArr! {
                
                let path = (cachePath)! + "/\(file)"
                if FileManager.default.fileExists(atPath: path) {
                    
                    do {
                        try FileManager.default.removeItem(atPath: path)
                    } catch {
                        
                    }
                }
            }
            //清除后刷新lable
            self.sizeL.text = String(self.fileSizeOfCache()) + "MB";
            
            XZAlertView.addXZAlertView(self.view, title: "缓存清理完成");
        }
        
        alert.addAction(cancle)
        alert.addAction(action);
        self.present(alert, animated: true, completion: nil);
    }

    
    //计算缓存文件大小
    func fileSizeOfCache()-> Int {
        
        // 取出cache文件夹目录 缓存文件都在这个目录下
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        //缓存目录路径
//        print(cachePath)
        
        // 取出文件夹下所有文件数组
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        
        //快速枚举出所有文件名 计算文件大小
        var size = 0
        for file in fileArr! {
            
            // 把文件名拼接到路径中
            let path = (cachePath)! + "/\(file)"
            // 取出文件属性
            let floder = try! FileManager.default.attributesOfItem(atPath: path)
            // 用元组取出文件大小属性
            for (abc, bcd) in floder {
                // 累加文件大小
                if abc == FileAttributeKey.size {
                    size += (bcd as AnyObject).intValue
                }
            }
        }
        
        let mm = size / 1024 / 1024
        self.sizeL.text = String(mm) + "MB";
        return mm
    }
    
    
    @IBOutlet weak var versionL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 242 / 255, green: 80 / 255, blue: 85 / 255, alpha: 1)
        navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .plain, target: nil, action: nil);
        self.navigationItem.title = "关于";
//        let imageView = UIImageView(image: UIImage(named: "header"));
//        self.navigationItem.titleView = imageView;
        self.navigationController?.navigationBar.isTranslucent = false;
        self.tableView.tableFooterView = UIView.init(frame: CGRect.zero);
        self.tableView.bounces = false;
        self.tableView.backgroundColor = UIColor.init(red: 239/255, green: 239/255, blue: 239/255, alpha: 1);
        self.picView.isUserInteractionEnabled = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _ = self.fileSizeOfCache();
        UnityAds.initialize("1178882", delegate: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension InfoTableViewController: UnityAdsDelegate {
    func unityAdsReady(_ placementId: String) {
        
        self.unityAds.isHidden = false
    }
    
    func unityAdsDidStart(_ placementId: String) {
        
    }
    
    func unityAdsDidError(_ error: UnityAdsError, withMessage message: String) {
        
    }
    
    func unityAdsDidFinish(_ placementId: String, with state: UnityAdsFinishState) {
//        if state != .skipped {
//            rewardUserForWatchingAnAd()
//        }
    }

}
