//
//  GSViewController.swift
//  Tang
//
//  Created by JGCM on 16/9/7.
//  Copyright © 2016年 xuanZheJiang. All rights reserved.
//

import UIKit
import CoreLocation

class GSViewController: UIViewController {
    
    var GSView: UIView!;
    var coverUrl: String!;
    var titleL: String!;
    var shareMsg: String!;
    var url: String!;
    let imageView = UIImageView.init();
    var buttonCOPY: UIButton!;
    var buttonWXT: UIButton!;
    var buttonWXF: UIButton!;
    var buttonQQ: UIButton!;
    var buttonQzone: UIButton!;
    var buttonWeiBo: UIButton!;
    
    let WBI = WeiboSDK.isWeiboAppInstalled();
    let QQI = QQApiInterface.isQQInstalled();
    let WXI = WXApi.isWXAppInstalled();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scale = CGAffineTransform(scaleX: 0, y: 0);
        let tranlate = CGAffineTransform(translationX: 0, y: 400);
        imageView.sd_setImage(with: URL.init(string: self.coverUrl)!);
        
        self.view.backgroundColor = UIColor.white;
        GSView.frame = self.view.frame;
        self.view.addSubview(GSView);
        let gsView = UIVisualEffectView(effect: UIBlurEffect(style: .light));
        gsView.frame = self.GSView.frame;
        GSView.addSubview(gsView);
        
        
        buttonWXF = UIButton.init(frame: CGRect(x: SCREEN_W / 6 , y: SCREEN_H / 3, width: 58, height: 58))
        buttonWXF.setTitle("微信好友", for: UIControlState())
        buttonWXF.setBackgroundImage(UIImage.init(named: "MFWShare_wechat_session"), for: UIControlState());
        buttonWXF.titleEdgeInsets = UIEdgeInsetsMake(80, 0, 0, 0);
        buttonWXF.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight);
        buttonWXF.setTitleColor(UIColor.black, for: UIControlState())
        buttonWXF.addTarget(self, action: #selector(self.shareToSnsPlat(_:)), for: UIControlEvents.touchUpInside)
        buttonWXF.transform = scale.concatenating(tranlate);
        view.addSubview(buttonWXF)
        
        buttonWXT = UIButton.init(frame: CGRect(x: SCREEN_W / 6 * 2 + 30 , y: SCREEN_H / 3, width: 58, height: 58))
        buttonWXT.setTitle("朋友圈", for: UIControlState())
        buttonWXT.setBackgroundImage(UIImage.init(named: "MFWShare_wechat_timeline"), for: UIControlState());
        buttonWXT.titleEdgeInsets = UIEdgeInsetsMake(80, 0, 0, 0);
        buttonWXT.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight);
        buttonWXT.setTitleColor(UIColor.black, for: UIControlState())
        buttonWXT.addTarget(self, action: #selector(self.shareToWechatTime), for: UIControlEvents.touchUpInside)
        buttonWXT.transform = scale.concatenating(tranlate);
        view.addSubview(buttonWXT)
        
        
        buttonCOPY = UIButton.init(frame: CGRect(x: SCREEN_W / 6 * 3 + 60, y: SCREEN_H / 3, width: 58, height: 58))
        buttonCOPY.setTitle("复制链接", for: UIControlState())
        buttonCOPY.setBackgroundImage(UIImage.init(named: "share_copy"), for: UIControlState());
        buttonCOPY.titleEdgeInsets = UIEdgeInsetsMake(80, 0, 0, 0);
        buttonCOPY.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight);
        buttonCOPY.setTitleColor(UIColor.black, for: UIControlState())
        buttonCOPY.addTarget(self, action: #selector(self.copyUrl), for: UIControlEvents.touchUpInside)
        buttonCOPY.transform = scale.concatenating(tranlate);
        view.addSubview(buttonCOPY)
        
        buttonQQ = UIButton.init(frame: CGRect(x: SCREEN_W / 6, y: SCREEN_H / 3 + 100, width: 58, height: 58))
        buttonQQ.setTitle("QQ好友", for: UIControlState())
        buttonQQ.setBackgroundImage(UIImage.init(named: "MFWShare_qq_friend"), for: UIControlState());
        buttonQQ.titleEdgeInsets = UIEdgeInsetsMake(80, 0, 0, 0);
        buttonQQ.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight);
        buttonQQ.setTitleColor(UIColor.black, for: UIControlState())
        buttonQQ.addTarget(self, action: #selector(self.shareToQQ), for: UIControlEvents.touchUpInside)
        buttonQQ.transform = scale.concatenating(tranlate);
        view.addSubview(buttonQQ)
        
        buttonQzone = UIButton.init(frame: CGRect(x: SCREEN_W / 6 * 2 + 30, y: SCREEN_H / 3 + 100, width: 58, height: 58))
        buttonQzone.setTitle("QQ空间", for: UIControlState())
        buttonQzone.setBackgroundImage(UIImage.init(named: "MFWShare_qq_qzone"), for: UIControlState());
        buttonQzone.titleEdgeInsets = UIEdgeInsetsMake(80, 0, 0, 0);
        buttonQzone.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight);
        buttonQzone.setTitleColor(UIColor.black, for: UIControlState())
        buttonQzone.addTarget(self, action: #selector(self.shareToQQ), for: UIControlEvents.touchUpInside)
        buttonQzone.transform = scale.concatenating(tranlate);
        view.addSubview(buttonQzone)
        
        buttonWeiBo = UIButton.init(frame: CGRect(x: SCREEN_W / 6 * 3 + 60, y: SCREEN_H / 3 + 100, width: 58, height: 58))
        buttonWeiBo.setTitle("新浪微博", for: UIControlState())
        buttonWeiBo.setBackgroundImage(UIImage.init(named: "MFWShare_sinaWeibo"), for: UIControlState());
        buttonWeiBo.titleEdgeInsets = UIEdgeInsetsMake(80, 0, 0, 0);
        buttonWeiBo.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight);
        buttonWeiBo.setTitleColor(UIColor.black, for: UIControlState())
        buttonWeiBo.addTarget(self, action: #selector(self.shareToWeiBo), for: UIControlEvents.touchUpInside)
        buttonWeiBo.transform = scale.concatenating(tranlate);
        view.addSubview(buttonWeiBo)
        
    }
    
    func shareToSnsPlat(_ button: UIButton) -> Void {
        UMSocialDataService.default().postSNS(withTypes: [UMShareToWechatSession], content: self.shareMsg, image: self.imageView.image, location: nil, urlResource: UMSocialUrlResource.init(snsResourceType: UMSocialUrlResourceTypeWeb, url: self.url),presentedController:self) { (respose) in}
        self.dismiss(animated: true, completion: nil);
    }
    
    func shareToWechatTime() -> Void {
        UMSocialDataService.default().postSNS(withTypes: [UMShareToWechatTimeline], content: self.shareMsg, image: self.imageView.image, location: nil, urlResource: UMSocialUrlResource.init(snsResourceType: UMSocialUrlResourceTypeWeb, url: self.url),presentedController:self) { (respose) in}
        self.dismiss(animated: true, completion: nil);
    }
    
    func copyUrl() -> Void {
        let copy = UIPasteboard.general;
        copy.string = self.url;
        self.dismiss(animated: true) { 
            NotificationCenter.default.post(name: Notification.Name(rawValue: "copy"), object: self);
        }
    }
    
    func shareToQQ() -> Void {
        let urlResource = UMSocialUrlResource(snsResourceType: UMSocialUrlResourceTypeImage, url: self.coverUrl);
        
        UMSocialDataService.default().postSNS(withTypes: [UMShareToQQ], content: self.titleL, image: nil, location: nil, urlResource: urlResource,presentedController:self) { (respose) in}
        self.dismiss(animated: true, completion: nil);
        
    }
    
    func shareToWeiBo() -> Void {
        
        let urlResource = UMSocialUrlResource(snsResourceType: UMSocialUrlResourceTypeImage, url: self.coverUrl);
        
        UMSocialDataService.default().postSNS(withTypes: [UMShareToSina], content: self.titleL + self.url, image: nil, location: nil, urlResource: urlResource, presentedController: self) { (respose) in
            
        }
        self.dismiss(animated: true, completion: nil);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 0.5, delay: 0.10, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.buttonCOPY.transform = CGAffineTransform.identity;
            }, completion: nil)
        
        if WXI == true {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.buttonWXF.transform = CGAffineTransform.identity;
                }, completion: nil)
            
            UIView.animate(withDuration: 0.5, delay: 0.05, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.buttonWXT.transform = CGAffineTransform.identity;
                }, completion: nil)
        }
        
        if QQI == true {
            UIView.animate(withDuration: 0.5, delay: 0.15, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.buttonQQ.transform = CGAffineTransform.identity;
                }, completion: nil)
            
            UIView.animate(withDuration: 0.5, delay: 0.20, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.buttonQzone.transform = CGAffineTransform.identity;
                }, completion: nil)
        }
        
        if WBI == true {

            UIView.animate(withDuration: 0.5, delay: 0.30, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    self.buttonWeiBo.transform = CGAffineTransform.identity;
                }, completion: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
            self.dismiss(animated: true, completion: nil);
    }


}
