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
    @IBOutlet weak var categoryTag: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        makeLayout()
        
        
        //Profile Picture UI Set-up
        profilePic.layer.cornerRadius = 20.0
        profilePic.clipsToBounds = true
        
        
    }
    

    
    func makeLayout(){
        let viewWidthUnit = viewWidth/20
        let viewHeightUnit = viewHeight/20

        self.frame = CGRectMake(0, 0, viewWidth, 300)
        itemImage.frame = CGRectMake(0, 0, viewWidth, 230)
        itemName.frame = CGRectMake(15, 237, viewWidthUnit*16, 25)
        profilePic.frame = CGRectMake(viewWidth-15-38 , 237, 38, 38)
        categoryTag.frame = CGRectMake(15, 268, 93, 25)
        itemCategory.frame = CGRectMake(21, 270, 80, 21)
        userName.frame = CGRectMake(viewWidth-15-150 , 274, 150, 21)

        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
