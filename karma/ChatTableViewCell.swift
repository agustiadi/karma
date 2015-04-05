//
//  ChatTableViewCell.swift
//  karma
//
//  Created by Agustiadi on 5/4/15.
//  Copyright (c) 2015 Agustiadi. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet var currentUserPic: UIImageView!
    @IBOutlet var currentUserMessage: UILabel!
    
    @IBOutlet var otherUserPic: UIImageView!
    @IBOutlet var otherUserMessage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        currentUserPic.layer.cornerRadius = 20
        currentUserPic.clipsToBounds = true
    
        currentUserMessage.font = UIFont(name: "Helvetica Neuse", size: 13)
        currentUserMessage.textAlignment = NSTextAlignment.Center
        currentUserMessage.textColor = UIColor.blackColor()
        currentUserMessage.numberOfLines = 0
        currentUserMessage.layer.cornerRadius = 10
        currentUserMessage.clipsToBounds = true

        
        otherUserPic.layer.cornerRadius = 20
        otherUserPic.clipsToBounds = true
        
        otherUserMessage.font = UIFont(name: "Helvetica Neuse", size: 13)
        otherUserMessage.textAlignment = NSTextAlignment.Center
        otherUserMessage.textColor = UIColor.blackColor()
        otherUserMessage.numberOfLines = 0
        otherUserMessage.layer.cornerRadius = 10
        otherUserMessage.clipsToBounds = true
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
