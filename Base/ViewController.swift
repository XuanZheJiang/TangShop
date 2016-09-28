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
    var timer1: Timer!;
    var timer2: Timer!;
    override func viewDidLoad() {
        super.viewDidLoad()

        timer1 = Timer.scheduledTimer(timeInterval: 1.91, target: self, selector: #selector(self.stop), userInfo: nil, repeats: false);
        timer2 = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.action), userInfo: nil, repeats: true);
    }
    
    func stop() -> Void {
        timer2.invalidate();
        timer2 = nil;
    }
    
    func action() -> Void {
        UIView.animate(withDuration: 1, animations: { 
            
            self.ttImageView.transform = self.ttImageView.transform.rotated(by: 1);
            
        }) 
    }

    


}

