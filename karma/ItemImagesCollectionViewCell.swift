//
//  ItemImagesCollectionViewCell.swift
//  karma
//
//  Created by Agustiadi on 31/3/15.
//  Copyright (c) 2015 Agustiadi. All rights reserved.
//

import UIKit

class ItemImagesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var itemImageView: UIImageView!
    
    @IBOutlet var indicatorLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        makeLayout()
        
    }
    
    
    
    func makeLayout(){
        let viewWidthUnit = viewWidth/20
        let viewHeightUnit = viewHeight/20
        
        self.frame = CGRectMake(0, 0, viewWidth, 230)
        itemImageView.frame = CGRectMake(0, 0, viewWidth, 230)
        indicatorLabel.frame = CGRectMake(viewWidth-90, 193, 75, 30)
        
        
    }

    
}
