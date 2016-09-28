//
//  CategoryMidDetailViewController.swift
//  Tang
//
//  Created by JGCM on 16/8/17.
//  Copyright © 2016年 xuanZheJiang. All rights reserved.
//

import UIKit
import SwiftyJSON
class CategoryMidDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H));
        tableView.backgroundColor = UIColor.white;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
        tableView.separatorStyle = .none;
        tableView.showsVerticalScrollIndicator = false;
        tableView.backgroundColor = UIColor.init(white: 0.95, alpha: 1);
        tableView.register(UINib.init(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell");
        return tableView;
    }()
    
    var dataArr = [HomeModel]();
    var id: Int!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .plain, target: nil, action: nil);
        self.view.addSubview(tableView);
        self.loadData();
    }

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
        let TWEBVC = TopWebViewController();
        TWEBVC.url = model.contentUrl;
        TWEBVC.coverUrl = model.coverImageUrl;
        TWEBVC.titleL = model.title;
        TWEBVC.navigationItem.title = "攻略详情";
        TWEBVC.shareMsg = model.shareMsg;
        TWEBVC.hidesBottomBarWhenPushed = false;
        self.navigationController?.pushViewController(TWEBVC, animated: true);
    }
    
    
    func loadData() -> Void {
        let url = "http://api.dantangapp.com/v1/channels/\(id!)/items?limit=20&offset=0";
        BaseRequest.getWithURL(url, para: nil) { (data, error) in
//            let str = String(data: data!, encoding: String.Encoding.utf8);
//            print(str!);
            let obj = JSON.init(data: data!, options: JSONSerialization.ReadingOptions.mutableContainers);
            let array = obj["data"]["items"].arrayValue;
            for item in array {
                let model = HomeModel.init(fromJson: item);
                model.coverImageUrl = item["cover_image_url"].string;
                model.title = item["title"].string;
                model.likesCount = item["likes_count"].intValue;
                self.dataArr.append(model);
            }
            DispatchQueue.main.async(execute: { 
                self.tableView.reloadData();
            })
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.8, 0.8, 1);
        UIView.animate(withDuration: 0.4, delay: 0, options: UIViewAnimationOptions.allowUserInteraction, animations: {
                cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
            }, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
