//
//  DetailedItemViewController.swift
//  karma
//
//  Created by Agustiadi on 16/3/15.
//  Copyright (c) 2015 Agustiadi. All rights reserved.
//

import UIKit

class DetailedItemViewController: UIViewController{
    
    var nameOfGiver = String()
    var giverPic = UIImage()
    var imagePic = UIImage()
    var nameOfItem = String()
    var categoryOfItem = String()
    var descriptionOfItem = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.setToolbarHidden(true, animated: true)
        
        let navBarHeight = navigationController?.navigationBar.frame.height
        
        let scrollView = UIScrollView(frame: CGRectMake(0, 0 , self.view.frame.width, self.view.frame.height + navBarHeight!))
        
        let profilePic = UIImageView(frame: CGRectMake(10, 5, 50, 50))
        profilePic.layer.cornerRadius = 25
        profilePic.clipsToBounds = true
        profilePic.image = giverPic
        
        let giverNameLabel = UILabel(frame: CGRectMake(70, 15, 200, 30))
        giverNameLabel.text = nameOfGiver
        
        let itemImage = UIImageView(frame: CGRectMake(0, 60, self.view.frame.width, 250))
        itemImage.image = imagePic
        
        let itemNameLabel = UILabel(frame: CGRectMake(10, 315, 200, 30))
        itemNameLabel.text = nameOfItem
        
        let categoryLabel = UILabel(frame: CGRectMake(10, 345, 200, 30))
        categoryLabel.text = categoryOfItem
        categoryLabel.font = categoryLabel.font.fontWithSize(15)
        
            
        let descriptionLabel = UILabel(frame: CGRectMake(10, 380, self.view.frame.width-20, 9999))
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = descriptionOfItem
        descriptionLabel.sizeToFit()
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 400 + navBarHeight! + descriptionLabel.frame.height )
        
        
        let wantItBtn = UIButton(frame: CGRectMake(0, self.view.frame.height + navBarHeight! - 50, self.view.frame.width, 50))
        wantItBtn.backgroundColor = UIColor.grayColor()
        wantItBtn.setTitle("Want It !", forState: UIControlState.Normal)
        //wantItBtn.addTarget(self, action: "wantIt:", forControlEvents: UIControlEvents.TouchUpInside)

        self.view.addSubview(scrollView)
        self.view.addSubview(wantItBtn)
        scrollView.addSubview(profilePic)
        scrollView.addSubview(giverNameLabel)
        scrollView.addSubview(itemImage)
        scrollView.addSubview(itemNameLabel)
        scrollView.addSubview(categoryLabel)
        scrollView.addSubview(descriptionLabel)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
