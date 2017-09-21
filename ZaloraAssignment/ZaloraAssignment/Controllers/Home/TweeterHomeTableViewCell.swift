//
//  TweeterHomeTableViewCell.swift
//  ZaloraAssignment
//
//  Created by Thanh Tran on 9/21/17.
//  Copyright © 2017 Thanh. All rights reserved.
//

import UIKit

class TweeterHomeTableViewCell: UITableViewCell {
  
  @IBOutlet weak var lblPostContent: UILabel!
  
  @IBOutlet weak var lblDate: UILabel!

  @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      containerView.layer.cornerRadius = 5
      containerView.layer.borderColor = UIColor.black.cgColor
      containerView.layer.borderWidth = 1
      
      lblPostContent.numberOfLines = 0
      lblPostContent.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
