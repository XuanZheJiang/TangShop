//
//  XZAlertView.swift
//  alert
//
//  Created by 蒋轩哲 on 16/9/21.
//  Copyright © 2016年 蒋轩哲. All rights reserved.
//

import UIKit

private var warningText: UILabel!;
private var timer: Timer?

class XZAlertView {

    class func addXZAlertView(_ view: UIView, title: String) {

        warningText = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width / 2, height: 30));
        warningText.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height / 2 - 50);
        warningText.text = title;
        warningText.backgroundColor = UIColor(white: 0.0, alpha: 0.7);
        warningText.textColor = UIColor.white;
        warningText.textAlignment = NSTextAlignment.center;
        warningText.layer.cornerRadius = 7;
        warningText.clipsToBounds = true;
        view.addSubview(warningText);
        
        
        func shakeToUpShow(_ aView: UIView) {
            let animation = CAKeyframeAnimation(keyPath: "transform");
            animation.duration = 0.4;
            let values = NSMutableArray();
            values.add(NSValue(caTransform3D: CATransform3DMakeScale(0.1, 0.1, 1.0)));
            values.add(NSValue(caTransform3D: CATransform3DMakeScale(1.2, 1.2, 1.0)));
            values.add(NSValue(caTransform3D: CATransform3DMakeScale(0.9, 0.9, 1.0)));
            values.add(NSValue(caTransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)));
            animation.values = values as [AnyObject];
            aView.layer.add(animation, forKey: nil);
        }
        
        func runTime() {
            timer = Timer(timeInterval: 0.5, target: self, selector: #selector(XZAlertView.methodTime), userInfo: nil, repeats: true)
            if timer != nil {
                RunLoop.current.add(timer!, forMode: RunLoopMode.defaultRunLoopMode);
            }
        }

        shakeToUpShow(warningText);
        runTime();
    }
    
    @objc fileprivate class func methodTime() {
        
        if timer?.isValid == true {
            timer?.invalidate();
        }
        timer = nil
        UIView.beginAnimations(nil, context: nil);
        UIView.setAnimationCurve(UIViewAnimationCurve.easeIn);
        UIView.setAnimationDuration(0.7);
        UIView.setAnimationDelegate(self);
        warningText.alpha = 0.0;
        UIView.commitAnimations();
    }
}
