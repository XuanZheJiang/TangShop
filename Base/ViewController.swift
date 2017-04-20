//
//  ViewController.swift
//  affine
//
//  Created by JGCM on 16/8/26.
//  Copyright © 2016年 JGCM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var ttImageView: UIImageView!
//    var timer1: Timer!;
//    var timer2: Timer!;
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ani1 = CABasicAnimation()
        ani1.keyPath = "transform.scale"
        ani1.toValue = 0
        
        let ani2 = CABasicAnimation()
        ani2.keyPath = "transform.rotation"
        ani2.toValue = Double.pi * 6
        
        let ani = CAAnimationGroup()
        ani.animations = [ani1, ani2]
        ani.duration = 2
        ani.isRemovedOnCompletion = false
        ani.fillMode = kCAFillModeForwards
        self.ttImageView.layer.add(ani, forKey: "")
//        timer1 = Timer.scheduledTimer(timeInterval: 1.91, target: self, selector: #selector(self.stop), userInfo: nil, repeats: false);
//        timer2 = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.action), userInfo: nil, repeats: true);
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
//    func stop() -> Void {
//        timer2.invalidate();
//        timer2 = nil;
//    }
//    
//    func action() -> Void {
//        UIView.animate(withDuration: 1, animations: { 
//            
//            self.ttImageView.transform = self.ttImageView.transform.rotated(by: 1);
//            
//        }) 
//    }

    


}

