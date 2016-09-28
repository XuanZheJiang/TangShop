//
//  CopyrightViewController.swift
//  Tang
//
//  Created by JGCM on 16/8/25.
//  Copyright © 2016年 xuanZheJiang. All rights reserved.
//

import UIKit

class CopyrightViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
        let textView = UITextView.init(frame: self.view.bounds);
        textView.textContainerInset = UIEdgeInsetsMake(0, 0, 113, 0);
        
        textView.text = "----------------------------------------\n本程序使用的第三方库\n\nSwiftyJSON(MIT License)\nCopyright © 2014 Ruoyu Fu\n\nSDWebImage(MIT License)\nCopyright © 2016 Olivier Poitrey\n\nMBProgressHUD(MIT License)\nCopyright © 2009-2016 Matej Bukovinski\n\nMJRefresh(MIT License)\nCopyright © 2013-2015 MJRefresh\n\nDGElasticPullToRefresh(MIT License)\nCopyright © 2015 Danil Gontovnik\n\nSDCycleScrollView(MIT License)\nCopyright © 2015 GSD_iOS\n----------------------------------------\n\n本程序所使用的图片、链接等数据来源于网络，其版权在不违反官方版权的前提下遵循提供者的版权声明\n\nThe program uses pictures , links and other data from the network, which copyrights without violating copyright follow the official provider claims.\n\n----------------------------------------\n";
        textView.font = UIFont.systemFont(ofSize: 14);
        textView.isEditable = false;
        self.view.addSubview(textView);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
