//
//  ItemListTableViewCell.swift
//  karma
//
//  Created by Agustiadi on 18/3/15.
//  Copyright (c) 2015 Agustiadi. All rights reserved.
//

import UIKit

class ItemListTableViewCell: UITableViewCell {
    
    //IBOutlets for Prototype Cell Elements
    @IBOutlet var itemImage: UIImageView!
    @IBOutlet var itemName: UILabel!
    @IBOutlet var itemCategory: UILabel!
    @IBOutlet var profilePic: UIImageView!
    @IBOutlet var userName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //Profile Picture UI Set-up
        profilePic.layer.cornerRadius = 20.0
        profilePic.clipsToBounds = true
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
