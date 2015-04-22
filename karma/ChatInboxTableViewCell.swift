//
//  ChatInboxTableViewCell.swift
//  karma
//
//  Created by Agustiadi on 7/4/15.
//  Copyright (c) 2015 Agustiadi. All rights reserved.
//

import UIKit

class ChatInboxTableViewCell: UITableViewCell {

    @IBOutlet var profilePic: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var latestMessage: UILabel!
    @IBOutlet var dateAndTime: UILabel!
    @IBOutlet var unreadLabel: UILabel!
    @IBOutlet var itemName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        profilePic.layer.cornerRadius = 35
        profilePic.clipsToBounds = true
        
        latestMessage.textColor = UIColor.lightGrayColor()
        
        unreadLabel.layer.cornerRadius = 15
        unreadLabel.clipsToBounds = true
        unreadLabel.textColor = UIColor.clearColor()
        unreadLabel.backgroundColor = UIColor.clearColor()
        
        itemName.textColor = UIColor.grayColor()

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
