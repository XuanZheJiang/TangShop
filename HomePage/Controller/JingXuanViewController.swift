//
//  JingXuanViewController.swift
//  Tang
//
//  Created by JGCM on 16/8/15.
//  Copyright © 2016年 xuanZheJiang. All rights reserved.
//  精选页面

import UIKit
import SDCycleScrollView
import MJRefresh
import SwiftyJSON
import AFNetworking

class JingXuanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate {

    lazy var adView: SDCycleScrollView = {
        let adView = SDCycleScrollView.init(frame: CGRect(x: 10, y: 0, width: SCREEN_W - 20, height: 150), delegate: self, placeholderImage: nil);
        adView?.layer.cornerRadius = 5;
        adView?.layer.masksToBounds = true;
        return adView!
    }()

    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H));
        tableView.contentInset = UIEdgeInsetsMake(30, 0, 143, 0);
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = .none;
        tableView.showsVerticalScrollIndicator = false;
        tableView.tableHeaderView = self.headerView;
        tableView.backgroundColor = UIColor.init(white: 0.95, alpha: 1);
        
        tableView.register(UINib.init(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell");
        return tableView;
    }()
    
    lazy var headerView : UIView = {
        let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_W, height: 150))
        headerView.addSubview(self.adView)
        return headerView
    }()
    

    var dataArr = [HomeModel]();
    var ofSet = 0;
    var urlArr = [String]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.ofSet = 0;
            self.loadData()
        })
        
        self.tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.ofSet += 20;
            self.loadData()
        })
        self.loadHeaderData();
        self.loadData();
        self.view.addSubview(tableView);
    }

    func loadHeaderData() -> Void {
        let url = "http://api.dantangapp.com/v1/banners?channel=iOS";
        BaseRequest.getWithURL(url, para: nil) { (data, error) in
            let obj = JSON.init(data: data!, options: JSONSerialization.ReadingOptions.mutableContainers);
            let modelArray = obj["data"]["banners"].arrayValue;
            for dic in modelArray {
                self.urlArr.append(dic["image_url"].stringValue);
                DispatchQueue.main.async {
                    self.adView.imageURLStringsGroup = self.urlArr;
                }
            }
            
        }
    }
    
    
    func loadData() -> Void {
        
        let url = BASE_URL + "v1/channels/4/items";
        let para = ["gender": "1",
                    "generation": "1",
                    "limit": "20",
                    "offset": String(self.ofSet)];
        
        let manager1 = AFHTTPSessionManager();
        manager1.responseSerializer = AFHTTPResponseSerializer();
        manager1.get(url, parameters: para, progress: nil, success: { (task, responce) in
            if self.ofSet == 0
            {
                self.dataArr.removeAll();
            }
            let obj = JSON.init(data: responce as! Data, options: JSONSerialization.ReadingOptions.mutableContainers);
            let modelArray = obj["data"]["items"].arrayValue;
            for item in modelArray {
                let model = HomeModel.init(fromJson: item);
                model.likesCount = item["likes_count"].intValue;
                model.coverImageUrl = item["cover_image_url"].string;
                model.title = item["title"].string;
                self.dataArr.append(model);
                DispatchQueue.main.async {
                    self.tableView.reloadData();
                    self.tableView.mj_header.endRefreshing();
                    self.tableView.mj_footer.endRefreshing();
                }
            }
            }) { (task, error) in
                print("errors");
        }
        
//        BaseRequest.getWithURL(url, para: para as NSDictionary?) { (data, error) in
//            let str = String.init(data: data!, encoding: String.Encoding.utf8);
//            print(str!);
//            if self.ofSet == 0
//            {
//                self.dataArr.removeAll();
//            }
//            let obj = JSON.init(data: data!, options: JSONSerialization.ReadingOptions.mutableContainers);
//            let modelArray = obj["data"]["items"].arrayValue;
//            for item in modelArray {
//                let model = HomeModel.init(fromJson: item);
//                model.likesCount = item["likes_count"].intValue;
//                model.coverImageUrl = item["cover_image_url"].string;
//                model.title = item["title"].string;
//                self.dataArr.append(model);
//                DispatchQueue.main.async {
//                    self.tableView.reloadData();
//                    self.tableView.mj_header.endRefreshing();
//                    self.tableView.mj_footer.endRefreshing();
//                }
//            }
//        }
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
    
//    override func viewWillAppear(_ animated: Bool) {
//        self.animateTable();
//    }
    
    func animateTable() {
        
        self.tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            
            let cell: UITableViewCell = a as UITableViewCell
            
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
                
                }, completion: nil)
            
            index += 1
        }
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
////        let cells = tableView.visibleCells
//        let tableHeight: CGFloat = tableView.bounds.size.height / 4;
//        
////        for i in cells {
////            let cell: UITableViewCell = i as UITableViewCell
//            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
////        }
//        
////        var index = 1
//        
////        for a in cells {
//        
////            let cell: UITableViewCell = a as UITableViewCell
//            
//            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
//                
//                cell.transform = CGAffineTransform(translationX: 0, y: 0);
//                
//                }, completion: nil)
//            
////            index += 1
////        }
//    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
