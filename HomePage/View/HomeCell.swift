//
//  HomeCell.swift
//  Tang
//
//  Created by JGCM on 16/8/15.
//  Copyright © 2016年 xuanZheJiang. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var headImage: UIImageView!
    
    @IBOutlet weak var titleL: UILabel!
    
    @IBOutlet weak var likeBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.headImage.layer.cornerRadius = 5;
        self.headImage.layer.masksToBounds = true;
        self.likeBtn.layer.cornerRadius = 10;
        self.likeBtn.layer.masksToBounds = true;
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
