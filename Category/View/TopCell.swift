//
//  TopCell.swift
//  Tang
//
//  Created by JGCM on 16/8/14.
//  Copyright © 2016年 xuanZheJiang. All rights reserved.
//

import UIKit

class TopCell: UICollectionViewCell {

    @IBOutlet weak var headImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.headImage.layer.cornerRadius = 5;
        self.headImage.layer.masksToBounds = true;
    }

}
