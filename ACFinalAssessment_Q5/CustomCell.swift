//
//  CustomCell.swift
//  ACFinalAssessment_Q5
//
//  Created by 張智涵 on 2016/8/5.
//  Copyright © 2016年 張智涵 Vincent Chang. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var customImage: UIImageView!
    @IBOutlet weak var customLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
