//
//  NiceViewController.swift
//  Tang
//
//  Created by JGCM on 16/8/16.
//  Copyright © 2016年 xuanZheJiang. All rights reserved.
//  美物页面

import UIKit
import SwiftyJSON
class NiceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H));
        tableView.contentInset = UIEdgeInsetsMake(30, 0, 143, 0);
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = .none;
        tableView.showsVerticalScrollIndicator = false;
        tableView.register(UINib.init(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell");
        return tableView;
    }()
    
    var dataArr = [HomeModel]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData();
        self.view.addSubview(tableView);
    }
    
    func loadData() -> Void {
        let url = BASE_URL + "v1/channels/13/items";
        let para = ["gender": "1",
                    "generation": "1",
                    "limit": "20",
                    "offset": "0"];
        BaseRequest.getWithURL(url, para: para as NSDictionary?) { (data, error) in
            //            let str = NSString.init(data: data!, encoding: NSUTF8StringEncoding);
            //            print(str!);
            let obj = JSON.init(data: data!, options: JSONSerialization.ReadingOptions.mutableContainers);
            let modelArray = obj["data"]["items"].arrayValue;
            for item in modelArray {
                let model = HomeModel.init(fromJson: item);
                model.likesCount = item["likes_count"].intValue;
                model.coverImageUrl = item["cover_image_url"].string;
                model.title = item["title"].string;
                self.dataArr.append(model);
                DispatchQueue.main.async {
                    self.tableView.reloadData();
                }
            }
        }
    }
    
    ///TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell;
        let model = dataArr[(indexPath as NSIndexPath).row];
        cell.headImage.sd_setImage(with: URL.init(string: model.coverImageUrl));
        cell.titleL.text = model.title;
        cell.likeBtn.setTitle(String(model.likesCount), for: UIControlState());
        cell.selectionStyle = .none;
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170;
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataArr[(indexPath as NSIndexPath).row];
        let JXDVC = JXDetailViewController();
        JXDVC.url = model.contentUrl;
        JXDVC.coverUrl = model.coverImageUrl;
        JXDVC.titleL = model.title;
        JXDVC.shareMsg = model.shareMsg;
        JXDVC.navigationItem.title = "攻略详情";
        JXDVC.hidesBottomBarWhenPushed = true;
        
        self.navigationController?.pushViewController(JXDVC, animated: true);
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
