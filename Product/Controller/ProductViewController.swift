//
//  ProductViewController.swift
//  Tang
//
//  Created by qianfeng on 2016/8/12.
//  Copyright © 2016年 xuanZheJiang. All rights reserved.
//  单品界面

import UIKit
import SwiftyJSON

class ProductViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    var collectionView: UICollectionView!;
    var dataArr = [ProductModel]();
       
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.hideBottomHairline()
        navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .plain, target: nil, action: nil);
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 242 / 255, green: 80 / 255, blue: 85 / 255, alpha: 1)
        self.navigationItem.title = "单品";
//        let imageView = UIImageView(image: UIImage(named: "header"));
//        self.navigationItem.titleView = imageView;
        self.automaticallyAdjustsScrollViewInsets = false;
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(self.search));
        self.view.backgroundColor = UIColor.init(white: 0.95, alpha: 1);
        self.createUI();
        self.loadData();
        
        
    }
    
    
    func search() -> Void {
        let searchVC = SearchViewController();
        searchVC.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(searchVC, animated: true);
    }
    
    
    func loadData() -> Void {
        let url = BASE_URL + "v2/items";
        let para = ["gender":"1","generation":"1","limit":"20","offset":"0"];
        
        
        BaseRequest.getWithURL(url, para: para as NSDictionary?) { (data, error) in
            if error == nil {
//                let str = NSString.init(data: data!, encoding: NSUTF8StringEncoding);
//                print(str!);   
                let obj = JSON.init(data: data!, options: JSONSerialization.ReadingOptions.init(rawValue: 7));
                let productArray = obj["data"]["items"].arrayValue;
                for items in productArray {
                    let item = items["data"];
                    let model = ProductModel(fromJson: item);
                    model.coverImageUrl = item["cover_image_url"].string;
                    model.name = item["name"].string;
                    model.favoritesCount = item["favorites_count"].intValue;
                    model.price = item["price"].string;
                    self.dataArr.append(model);
                }
                DispatchQueue.main.async(execute: {
                    self.collectionView.reloadData();
                })
            }
        }
        
    }
    
    func createUI() -> Void {
        collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: UICollectionViewFlowLayout());
        collectionView.backgroundColor = self.view.backgroundColor;
        collectionView.showsVerticalScrollIndicator = false;
        collectionView.register(UINib.init(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell");
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 113, 0)
        self.view.addSubview(collectionView);
        collectionView.reloadData();
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell;
        let model = dataArr[(indexPath as NSIndexPath).row];
        cell.headImage.sd_setImage(with: URL.init(string: model.coverImageUrl));
        cell.titleL.text = model.name;
        cell.priceL.text = "¥" + model.price;
        cell.likeBtn.setTitle(String(model.favoritesCount), for: UIControlState());

        return cell;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 5, 5, 5);
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (UIScreen.main.bounds.width - 20) / 2;
        let height: CGFloat = 220;
        return CGSize(width: width, height: height);
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = dataArr[(indexPath as NSIndexPath).item];
        let PDVC = ProductDetailViewController();
        PDVC.url = model.purchaseUrl;
        PDVC.hidesBottomBarWhenPushed = true;
        PDVC.navigationItem.title = "单品详情"
        self.navigationController?.pushViewController(PDVC, animated: true);
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
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
