//
//  SearchViewController.swift
//  Tang
//
//  Created by JGCM on 16/9/15.
//  Copyright © 2016年 xuanZheJiang. All rights reserved.
//

import UIKit
import SwiftyJSON
import AFNetworking

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar();
        searchBar.placeholder = "搜索商品、专题";
        return searchBar;
    }()
    
    weak var tableView: UITableView?
    
    func setupCollectionView() -> Void {
        
//        lazy var tableView: UITableView = {
            let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H));
            tableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
            tableView.delegate = self;
            tableView.dataSource = self;
            //        tableView.separatorStyle = .None;
            tableView.separatorColor = UIColor.white;
            tableView.showsVerticalScrollIndicator = false;
            tableView.backgroundColor = UIColor.init(white: 0.95, alpha: 1);
            tableView.register(UINib.init(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "SearchCell");
        self.tableView = tableView;
        self.view.addSubview(tableView);
//            return tableView;
//        }()
    }
    
    
    var dataArr = [HomeSearchModel]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNav();
        self.view.backgroundColor = UIColor.init(white: 0.95, alpha: 1);
    }
    
    func setupNav() -> Void {
        self.navigationItem.titleView = searchBar;
        searchBar.delegate = self;
        searchBar.tintColor = UIColor.init(white: 0.5, alpha: 1);
        searchBar.barTintColor = BASE_COLOR;
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: UIView());
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "取消", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.NavBackAction));
    }
    
    func NavBackAction() -> Void {
        _ = navigationController?.popViewController(animated: true);
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "checkUserType_backward_9x15_"), style: .plain, target: self, action: #selector(navigationBackClick))
    }
    
    /// 返回按钮、取消按钮点击
    func navigationBackClick() {
        _ = navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        searchBar.becomeFirstResponder();
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchBar.resignFirstResponder()
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        /// 设置collectionView
        setupCollectionView()
        return true;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.dataArr.removeAll();
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "checkUserType_backward_9x15_"), style: .plain, target: self, action: #selector(navigationBackClick))
        let keyWord = searchBar.text!;
        print(searchBar.text!);
        self.loadSearchData(keyWord);
    }
    
    
    
    func loadSearchData(_ keyWord: String) -> Void {
        let url = "http://api.dantangapp.com/v1/search/item";
        let para = ["keyword": keyWord,
                      "limit": "20",
                      "offset": "0",
                      "sort": ""];
        let manager1 = AFHTTPSessionManager();
        manager1.responseSerializer = AFHTTPResponseSerializer();
        manager1.get(url, parameters: para, progress: nil, success: { (task, res) in
            let obj = JSON.init(data: res as! Data, options: JSONSerialization.ReadingOptions.mutableContainers);
                let modelArray = obj["data"]["items"].arrayValue;
                for item in modelArray {
                    let model = HomeSearchModel.init(fromJson: item);
                    model.coverImageUrl = item["cover_image_url"].string;
                    model.name = item["name"].string;
                    model.price = item["price"].string;
                    model.id = item["id"].intValue;
                    self.dataArr.append(model);
                    DispatchQueue.main.async {
                        self.tableView?.reloadData();
                    }
                }
            }) { (task, error) in
                print("失败");
        }
//        BaseRequest.getWithURL(url, para: para as NSDictionary?) { (data, error) in
//            let str = String(data: data!, encoding: String.Encoding.utf8);
//            print(str!);
//            let obj = JSON.init(data: data!, options: JSONSerialization.ReadingOptions.mutableContainers);
//            let modelArray = obj["data"]["items"].arrayValue;
//            for item in modelArray {
//                let model = HomeSearchModel.init(fromJson: item);
//                model.coverImageUrl = item["cover_image_url"].string;
//                model.name = item["name"].string;
//                model.price = item["price"].string;
//                model.id = item["id"].intValue;
//                self.dataArr.append(model);
//                DispatchQueue.main.async {
//                    self.tableView?.reloadData();
//                }
//            }
//            
//        }
    }
    
//    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
//        self.dataArr.removeAll();
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "checkUserType_backward_9x15_"), style: .Plain, target: self, action: #selector(navigationBackClick))
//        let keyWord = searchBar.text!;
//        self.loadSearchData(keyWord, sort: "");
//    }
    
    //tableViewController
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell;
        let model = dataArr[(indexPath as NSIndexPath).row];
        cell.headImageView.sd_setImage(with: URL.init(string: model.coverImageUrl));
        cell.titleL.text = model.name;
        cell.priceL.text = "￥" + model.price;
        cell.selectionStyle = .none;
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataArr[(indexPath as NSIndexPath).row];
        let SearchDVC = SearchDetailViewController();
//        print(model.id);
//        SearchDVC.descriptionField = model.descriptionField;
//        SearchDVC.coverImageUrl = model.coverImageUrl;
        SearchDVC.id = String(model.id);
//        SearchDVC.navigationItem.title = "攻略详情";
        SearchDVC.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(SearchDVC, animated: true);
    }
    
    
    
//    func updateSearchResultsForSearchController(searchController: UISearchController) {
//        let searchText = searchController.searchBar.text!;
//        print(searchText);
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder();
    }
    
}
