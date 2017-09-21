//
//  TweeterEmptyTableViewCell.swift
//  ZaloraAssignment
//
//  Created by Thanh Tran on 9/21/17.
//  Copyright © 2017 Thanh. All rights reserved.
//

import UIKit

class TweeterEmptyTableViewCell: UITableViewCell {

  @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      containerView.layer.cornerRadius = 5
      containerView.layer.borderColor = UIColor.black.cgColor
      containerView.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
