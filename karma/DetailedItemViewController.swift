//
//  DetailedItemViewController.swift
//  karma
//
//  Created by Agustiadi on 16/3/15.
//  Copyright (c) 2015 Agustiadi. All rights reserved.
//

import UIKit

var nameOfItem = String()
var categoryOfItem = String()
var descriptionOfItem = String()
var giverID = String()
var objectID = NSObject()

class DetailedItemViewController: UIViewController{
    
    //IBOutlets Connections
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var profilePic: UIImageView!
    @IBOutlet var giverNameLabel: UILabel!
    @IBOutlet var itemImage: UIImageView!
    @IBOutlet var imageLabel: UILabel!
    @IBOutlet var itemNameLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBAction func wantItBtn(sender: AnyObject) {
        performSegueWithIdentifier("wantIt", sender: self)
        println("Want It Button Pressed")
    }

    var imagePic = UIImage()
    var itemImageIndex = 0
    var itemImagesFile = [PFFile]()
    var itemImages = [UIImage]()
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserData(giverID, name: giverNameLabel, profilePic: profilePic)
        getItemImages(objectID as PFObject)
        
        profilePic.layer.cornerRadius = 20
        profilePic.clipsToBounds = true
        
        itemImage.userInteractionEnabled = true
        itemImage.image = itemImages[0]
        
        // Adding Swipe Gesture Recognizer
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        itemImage.addGestureRecognizer(swipeLeft)
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        itemImage.addGestureRecognizer(swipeRight)
        
        //Add Image Index Indicator Label
        imageLabel.backgroundColor = UIColor.blackColor()
        imageLabel.alpha = 0.35
        imageLabel.textColor = UIColor.whiteColor()
        imageLabel.text = "1 of \(itemImages.count)"
        imageLabel.textAlignment = NSTextAlignment.Center
        imageLabel.font = UIFont(name: "Helvetica Neue", size: 10)
        
        itemNameLabel.text = nameOfItem
        
        categoryLabel.text = categoryOfItem
        categoryLabel.font = categoryLabel.font.fontWithSize(15)
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = descriptionOfItem
        descriptionLabel.sizeToFit()
                
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: descriptionLabel.frame.maxY + 10)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        navigationController?.setNavigationBarHidden(false, animated: true)

    }
    
    override func viewDidDisappear(animated: Bool) {
        
        scrollView.setContentOffset(CGPointZero, animated: true)
    }

    
    func respondToSwipeGesture(gesture: UIGestureRecognizer){
        
        let swipeGesture = gesture as? UISwipeGestureRecognizer
        
        if swipeGesture?.direction == UISwipeGestureRecognizerDirection.Left {
            
            println("swipeLeft")
            
            if itemImageIndex == itemImages.count - 1  {
                
                itemImageIndex = 0
                
            } else {
                
                itemImageIndex++
                
            }
            
            itemImage.image = itemImages[itemImageIndex]
            imageLabel.text = "\(itemImageIndex + 1) of \(itemImages.count)"
                
        }
                
        else if swipeGesture?.direction == UISwipeGestureRecognizerDirection.Right{
            
            println("swipeRight")
            
            if itemImageIndex == 0 {
                
                itemImageIndex = itemImages.count - 1
                
            } else {
                
                itemImageIndex--
                
            }
            
            itemImage.image = itemImages[itemImageIndex]
            imageLabel.text = "\(itemImageIndex + 1) of \(itemImages.count)"

        }
        
    }
    
    func getUserData(userID: String, name: UILabel, profilePic: UIImageView){
        
        var userQuery = PFQuery(className: "_User")
        userQuery.whereKey("objectId", equalTo: userID)
        userQuery.findObjectsInBackgroundWithBlock {
            (userObjects: [AnyObject]!, error: NSError!) -> Void in
            
            if error == nil {
                
                for user in userObjects {
                    
                    name.text = user["name"] as? String
                    
                    if user["profilePic"] != nil {
                        
                        let temp = user["profilePic"] as PFFile
                        temp.getDataInBackgroundWithBlock{
                            (imageData: NSData!, error: NSError!) -> Void in
                            
                            if error == nil {
                                
                                let image = UIImage(data: imageData)
                                profilePic.image = image
                                
                                
                            } else {
                                
                                println(error)
                                
                            }
                            
                        }
                        
                    }
                }
            } else {
                
                profilePic.image = UIImage(named: "profilePlaceholder")!
                
            }
            
        }
        
    }
    
    func getItemImages(objectID: PFObject) {
        
        self.itemImagesFile.removeAll(keepCapacity: true)
        
        var imageQuery = PFQuery(className: "ItemImages")
        imageQuery.whereKey("itemID", equalTo: objectID)
        var objects = imageQuery.findObjects()
        
        for object in objects {
            
            self.itemImagesFile.append(object["image"] as PFFile)
            self.itemImages.append(getUIImage(object["image"] as PFFile))
            
        }

    }

    func getUIImage(file: PFFile) -> UIImage {
        
        let temp = file as PFFile
        let data = temp.getData()
        let image = UIImage(data: data)
        
        return image!
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
