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
    var itemImageIndex = 0
    var itemImage = UIImageView()
    var imageLabel = UILabel()
    var itemImages = ["image1", "image2", "image3", "image4"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        itemImage = UIImageView(frame: CGRectMake(0, 60, self.view.frame.width, 250))
        itemImage.userInteractionEnabled = true
        itemImage.image = UIImage(named: itemImages[0])
        
        // Adding Swipe Gesture Recognizer
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        itemImage.addGestureRecognizer(swipeLeft)
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        itemImage.addGestureRecognizer(swipeRight)
        
        //Add Image Index Indicator Label
        imageLabel = UILabel(frame: CGRectMake(0, 0, 50, 15))
        imageLabel.center = CGPoint(x: self.itemImage.frame.width - 30, y: self.itemImage.frame.height - 15)
        imageLabel.backgroundColor = UIColor.blackColor()
        imageLabel.alpha = 0.35
        imageLabel.textColor = UIColor.whiteColor()
        imageLabel.text = "1 of \(itemImages.count)"
        imageLabel.textAlignment = NSTextAlignment.Center
        imageLabel.font = UIFont(name: "Helvetica Neue", size: 10)
        itemImage.addSubview(imageLabel)
        
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
        scrollView.addSubview(itemImage)
        scrollView.addSubview(profilePic)
        scrollView.addSubview(giverNameLabel)
        scrollView.addSubview(itemNameLabel)
        scrollView.addSubview(categoryLabel)
        scrollView.addSubview(descriptionLabel)
        
    }
    
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer){
        
        let swipeGesture = gesture as? UISwipeGestureRecognizer
        
        if swipeGesture?.direction == UISwipeGestureRecognizerDirection.Left {
            
            println("swipeLeft")
            
            if itemImageIndex == 0 {
                
                itemImageIndex = itemImages.count - 1
                
            } else {
                
                itemImageIndex--
                
            }
            
            itemImage.image = UIImage(named: itemImages[itemImageIndex])
            imageLabel.text = "\(itemImageIndex + 1) of \(itemImages.count)"
                
        }
                
        else if swipeGesture?.direction == UISwipeGestureRecognizerDirection.Right{
            
            println("swipeRight")
                
            if itemImageIndex == itemImages.count - 1  {
                
                itemImageIndex = 0
                
            } else {
                
                itemImageIndex++
                
            }
            
            itemImage.image = UIImage(named: itemImages[itemImageIndex])
            imageLabel.text = "\(itemImageIndex + 1) of \(itemImages.count)"
        
        }
        
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
