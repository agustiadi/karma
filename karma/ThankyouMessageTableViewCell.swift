//
//  ThankyouMessageTableViewCell.swift
//  karma
//
//  Created by Agustiadi on 27/3/15.
//  Copyright (c) 2015 Agustiadi. All rights reserved.
//

import UIKit

class ThankyouMessageTableViewCell: UITableViewCell {
    
    @IBOutlet var receiverProfilePic: UIImageView!
    @IBOutlet var receiverName: UILabel!
    @IBOutlet var itemName: UILabel!
    @IBOutlet var thankyouMessage: UILabel!
    @IBOutlet var iconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        receiverProfilePic.center = CGPoint(x: 55, y: 60)
        receiverProfilePic.layer.cornerRadius = 40
        receiverProfilePic.clipsToBounds = true
        
        receiverName.center = CGPoint(x: 60, y: 120)
        
        thankyouMessage.frame = CGRectMake(120, 15, 230, 100)
        thankyouMessage.numberOfLines = 7
        thankyouMessage.sizeToFit()
        
        iconImage.center = CGPoint(x: 200, y: 120)
        
        itemName.frame = CGRectMake(iconImage.frame.maxX + 5, 0, 150, 50)
        itemName.center.y = iconImage.center.y
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state

    }

}
