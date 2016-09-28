//
//  CategoryTopViewController.swift
//  Tang
//
//  Created by JGCM on 16/8/14.
//  Copyright © 2016年 xuanZheJiang. All rights reserved.
//

import UIKit
import SwiftyJSON
class CategoryTopViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var collectionView: UICollectionView!;
    var dataArr = [CategoryTopModel]();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.createUI();
        self.loadData();
    }
    
    func loadData() -> Void {
        let url = BASE_URL + "v1/collections"
        let para = ["limit":"4","offset":"0"]
        
        BaseRequest.getWithURL(url, para: para as NSDictionary?) { (data, error) in
            
//            let str = NSString.init(data: data!, encoding: NSUTF8StringEncoding);
//            print(str!);
            if error == nil {
                let obj = JSON.init(data: data!, options: JSONSerialization.ReadingOptions.mutableContainers);
                let categoryArray = obj["data"]["collections"].arrayValue;
                for items in categoryArray {
                    let model = CategoryTopModel.init(fromJson: items);
                    model.bannerImageUrl = items["banner_image_url"].string;
                    self.dataArr.append(model);
                    DispatchQueue.main.async {
                        self.collectionView.reloadData();
                    }
                }
            } else {
                print("error");
            }
        }
    }
    
    func createUI() -> Void {
        let headerView = Bundle.main.loadNibNamed("CategoryHeaderView", owner: nil, options: nil)?.last as! CategoryHeaderView;
        headerView.frame = CGRect(x: 0, y: 0, width: SCREEN_W, height: 40);
        self.view.addSubview(headerView);
        self.topScrollView();
        
        self.collectionView.reloadData()
    }
    
    //顶部滚动视图
    func topScrollView() -> Void {
        let layout = UICollectionViewFlowLayout();
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal;
        collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 40, width: SCREEN_W, height: 95), collectionViewLayout: layout);
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = UIColor.white;
        collectionView.register(UINib.init(nibName: "TopCell", bundle: nil), forCellWithReuseIdentifier: "TopCell");
        self.view.addSubview(collectionView!);
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopCell", for: indexPath) as! TopCell;
        let model = dataArr[(indexPath as NSIndexPath).item] ;
        cell.headImage.sd_setImage(with: URL.init(string: model.bannerImageUrl));
        return cell;
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 75);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = dataArr[(indexPath as NSIndexPath).item];
        let CTDVC = CategoryTopDetailViewController();
        CTDVC.id = model.id;
        CTDVC.navigationItem.title = model.title;
        CTDVC.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(CTDVC, animated: true);
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
