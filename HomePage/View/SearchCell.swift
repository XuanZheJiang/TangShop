//
//  SearchCell.swift
//  Tang
//
//  Created by JGCM on 16/9/15.
//  Copyright © 2016年 xuanZheJiang. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {

    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var priceL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.headImageView.layer.cornerRadius = 10;
        self.headImageView.layer.masksToBounds = true;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
