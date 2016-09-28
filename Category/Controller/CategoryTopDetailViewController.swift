//
//  CategoryTopDetailViewController.swift
//  Tang
//
//  Created by JGCM on 16/8/17.
//  Copyright © 2016年 xuanZheJiang. All rights reserved.
//

import UIKit
import SwiftyJSON
class CategoryTopDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    lazy var tableView: UITableView = {
        let tableView = UITableView();
        tableView.frame = CGRect(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H);
        tableView.register(UINib.init(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell");
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = UIColor.init(white: 0.95, alpha: 1);
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none;
        tableView.showsVerticalScrollIndicator = false;
        return tableView;
    }()
    
    var id: Int!;
    var dataArr = [CategoryTopDetailModel]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .plain, target: nil, action: nil);
        self.view.addSubview(tableView);
        self.loadData();
    }
    
    func loadData() -> Void {
        let url = BASE_URL + "v1/collections/\(id!)/posts"
        let para = ["gender": "1",
                      "generation": "1",
                      "limit": "20",
                      "offset": "0"]
        BaseRequest.getWithURL(url, para: para as NSDictionary?) { (data, error) in
//            let str = NSString.init(data: data!, encoding: NSUTF8StringEncoding);
//            print(str!);
            let obj = JSON.init(data: data!, options: JSONSerialization.ReadingOptions.mutableContainers);
            let CateTopDetailArray = obj["data"]["posts"].arrayValue;
            for post in CateTopDetailArray {
                let model = CategoryTopDetailModel.init(fromJson: post);
                model.coverImageUrl = post["cover_image_url"].string;
                model.likesCount = post["likes_count"].intValue;
                model.title = post["title"].stringValue;
                self.dataArr.append(model);
                DispatchQueue.main.async {
                    self.tableView.reloadData();
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell;
        let model = dataArr[(indexPath as NSIndexPath).item];
        cell.titleL.text = model.title;
        cell.headImage.sd_setImage(with: URL.init(string: model.coverImageUrl));
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
        TWEBVC.shareMsg = model.shareMsg;
        TWEBVC.navigationItem.title = "攻略详情";
        TWEBVC.hidesBottomBarWhenPushed = false;
        self.navigationController?.pushViewController(TWEBVC, animated: true);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
