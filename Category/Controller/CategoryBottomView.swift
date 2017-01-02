//
//  CategoryBottomView.swift
//  Tang
//
//  Created by JGCM on 16/8/14.
//  Copyright © 2016年 xuanZheJiang. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol CategoryDelegate: class {
    func push(_ button: UIButton) -> Void;
}

class CategoryBottomView: UIView {
    
    var dataArr = [CategoryBottomModel]();
    let topView = UIView();
    weak var delegate: CategoryDelegate!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.loadBtnJSON();
        
    }
    
    func bottomVieHieght()->CGFloat{
        
        let space: CGFloat = 20;
        let btnW = (SCREEN_W - 5 * space) / 4
        topView.frame.size.height = btnW + 30 + 40;
        
        return  topView.frame.size.height
    }
    
    func createUI() -> Void {
        
        topView.frame.size.width = SCREEN_W;
        topView.backgroundColor = UIColor.white;
        let lable = UILabel();
        lable.text = "风格";
        lable.textColor = UIColor.init(white: 0.4, alpha: 1);
        lable.frame = CGRect(x: 10, y: 0, width: SCREEN_W - 10, height: 40);
        topView.addSubview(lable);
        self.addSubview(topView);
        
        let space: CGFloat = 20;
        let btnW = (SCREEN_W - 5 * space) / 4;
        topView.frame.size.height = btnW + 30 + lable.mj_h;
        var i = 0;
        var tag = [12, 19, 20, 21];
        for model in dataArr {
            let orginX = CGFloat(i % 4) * (btnW + space) + space;
            let orginY = CGFloat(i / 4) * (btnW + space) + 40
            
            let btn = UIButton.init(frame: CGRect(x: orginX, y: orginY, width: btnW, height: btnW));
            btn.sd_setBackgroundImage(with: URL.init(string: model.iconUrl), for: UIControlState());
            btn.sd_setBackgroundImage(with: URL.init(string: model.iconUrl), for: .highlighted);
            btn.setTitle(model.name, for: UIControlState());
            btn.setTitleColor(UIColor.black, for: UIControlState());
            btn.titleLabel?.font = UIFont.init(name: "Helvetica-Light", size: 14);
            btn.titleEdgeInsets = UIEdgeInsetsMake(btnW + 30, 0, 0, 0);
            btn.addTarget(self, action: #selector(self.btnAction(_:)), for: UIControlEvents.touchUpInside);
            btn.tag = tag[i];
            self.topView.addSubview(btn);
            i += 1;
        }
        
    }
    
    func btnAction(_ button: UIButton) -> Void {
//        switch button.tag {
//        case 12:
//            self.delegate.push();
//        case 1001:
//            self.delegate.push();
//        case 1002:
//            self.delegate.push();
//        default:
//            self.delegate.push();
//        }
        self.delegate.push(button);
    }
    
    func loadBtnJSON() -> Void {
        let url = BASE_URL + "v1/channel_groups/all";
        BaseRequest.getWithURL(url, para: nil) { (data, error) in
            let obj = JSON.init(data: data!, options: JSONSerialization.ReadingOptions.mutableContainers);
            let btnArray = obj["data"]["channel_groups"].arrayValue;
            let group1 = btnArray[0];
            let item1 = group1["channels"].arrayValue;
            for item in item1 {
                let model = CategoryBottomModel.init(fromJson: item);
                model.iconUrl = item["icon_url"].string;
                model.name = item["name"].string;
                self.dataArr.append(model);
            }
            DispatchQueue.main.async(execute: {
                self.createUI();
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
