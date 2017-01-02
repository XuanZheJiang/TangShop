//
//  AppDelegate.swift
//  TangShop
//
//  Created by JGCM on 16/9/23.
//  Copyright © 2016年 蒋轩哲. All rights reserved.
//

import UIKit
//import CoreData
import SDVersion



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UIAlertViewDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow.init(frame: UIScreen.main.bounds);
        let tt = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ttt");
        self.window?.rootViewController = tt;
        let time = DispatchTime.now() + Double(2 * Int64(NSEC_PER_SEC)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.window?.rootViewController = JXZTabBarController();
        }
        window?.makeKeyAndVisible();
        UINavigationBar.appearance().tintColor = UIColor.white;
        UINavigationBar.appearance().barTintColor = BASE_COLOR;
        if let font = UIFont.init(name: "Avenir-Light", size: 18) {
            UINavigationBar.appearance().titleTextAttributes = [
                NSForegroundColorAttributeName:UIColor.white,
                NSFontAttributeName:font
            ];
        }
        self.registerAPNSJPush(launchOptions);
        
        self.UMShare(launchOptions);
        return true
    }
    
    //极光推送
    func registerAPNSJPush(_ options: [AnyHashable: Any]?) -> Void{
        
        JPUSHService.register(forRemoteNotificationTypes: UIUserNotificationType.badge.rawValue | UIUserNotificationType.alert.rawValue | UIUserNotificationType.sound.rawValue, categories: nil);
        JPUSHService.setup(withOption: options, appKey: JpushAppKey, channel: nil, apsForProduction: true);
        
    }
    
    //获取APNs下发的DeviceToken
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        JPUSHService.registerDeviceToken(deviceToken);
        let sss = SDiOSVersion.deviceVersion().rawValue
        //        print("sss = \(sss)");
        JPUSHService.setTags([String(sss)], aliasInbackground: String(sss));
    }
    
    //接收到消息
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        JPUSHService.handleRemoteNotification(userInfo);
        
        if application.applicationState == UIApplicationState.active || application.applicationState == UIApplicationState.background {
            
            let aps = userInfo["aps"] as! NSDictionary;
            let content = aps["alert"] as! String;
            let alert = UIAlertView(title: "新消息", message: content, delegate: self, cancelButtonTitle: nil, otherButtonTitles: "好");
            alert.show();
        } else {
            let aps = userInfo["aps"] as! NSDictionary;
            let content = aps["alert"] as! String;
            let alert = UIAlertView(title: "新消息", message: content, delegate: self, cancelButtonTitle: nil, otherButtonTitles: "好");
            alert.show();
        }
    }

    //友盟分享
    func UMShare(_ option:[AnyHashable: Any]?) -> Void {
        UMSocialData.setAppKey(AppKey);
        UMSocialWechatHandler.setWXAppId(wechatAppID, appSecret: wechatAppSecret, url: JXZ);
        UMSocialQQHandler.setQQWithAppId(QQAppID, appKey: QQAppKey, url: JXZ);
        UMSocialSinaSSOHandler.openNewSinaSSO(withAppKey: SinaAppID, secret: SinaAppSecret, redirectURL: JXZ);
    }


    func applicationWillResignActive(_ application: UIApplication) {
        JPUSHService.resetBadge();
        UIApplication.shared.applicationIconBadgeNumber = 0;
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension String {
    var md5 : String{
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen);
        
        CC_MD5(str!, strLen, result);
        
        let hash = NSMutableString();
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i]);
        }
        result.deinitialize();
        
        return String(format: hash as String)
    }
}

