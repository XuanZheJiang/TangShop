//
//  ProductCell.swift
//  Tang
//
//  Created by qianfeng on 2016/8/12.
//  Copyright © 2016年 xuanZheJiang. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {

    @IBOutlet weak var headImage: UIImageView!
    
    @IBOutlet weak var titleL: UILabel!
    
    @IBOutlet weak var priceL: UILabel!
    
    @IBOutlet weak var likeBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = true
    }

}
