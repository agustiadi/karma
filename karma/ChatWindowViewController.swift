//
//  ChatWindowViewController.swift
//  karma
//
//  Created by Agustiadi on 6/4/15.
//  Copyright (c) 2015 Agustiadi. All rights reserved.
//

import UIKit

class ChatWindowViewController: UIViewController {
    
    var itemID = "URkd2R5OLu"
    
    var currentUser = PFUser.currentUser()
    var currentUserID = PFUser.currentUser().objectId
    var currentUsername = PFUser.currentUser().username
    var currentUserProfilPic = UIImage(named: "profilePlaceholder")
    
    var otherUserID = "5h26UD6IVu"
    var otherUserProfilePic = UIImage(named: "profilePlaceholder")
    var otherUsername = "Joel Tan"
    
    @IBOutlet var resultScrollView: UIScrollView!
    @IBOutlet var frameMessageView: UIView!
    @IBOutlet var lineLabel: UILabel!
    @IBOutlet var messageTextView: UITextView!
    @IBOutlet var sendButton: UIButton!
    
    var scrollViewOriginalY: CGFloat = 0
    var frameMessageOriginalY: CGFloat = 0
    
    let placeholderLabel = UILabel(frame: CGRectMake(5, 8, 200, 20))
    
    var messageX: CGFloat = 37.0
    var messageY: CGFloat = 26.0
    
    var frameX: CGFloat = 32.0
    var frameY: CGFloat = 21.0
    
    var imageX: CGFloat = 3.0
    var imageY: CGFloat = 3.0
    
    
    var senderArray = [String]()
    var messageArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let theWidth = view.frame.width
        let theHeight = view.frame.height
        let navBarY = navigationController?.navigationBar.frame.maxY
        
        let unitW = theWidth/37.5  //10 per unit
        let unitH = theHeight/66.7 //10 per unit

        resultScrollView.frame = CGRectMake(0, 0, theWidth, theHeight - (navBarY! + 50))
        resultScrollView.backgroundColor = UIColor.whiteColor()
        resultScrollView.layer.zPosition = 20
        frameMessageView.frame = CGRectMake(0, resultScrollView.frame.maxY, theWidth, 50)
        lineLabel.frame = CGRectMake(0, 0, theWidth, 1)
        messageTextView.frame = CGRectMake(2, 2, self.frameMessageView.frame.size.width - 52, 48)
        sendButton.center = CGPointMake(frameMessageView.frame.width - 30, 24)
        
        scrollViewOriginalY = self.resultScrollView.frame.origin.y
        frameMessageOriginalY = self.frameMessageView.frame.origin.y
        
        self.title = otherUsername
        
        placeholderLabel.text = "Type a message ..."
        placeholderLabel.backgroundColor = UIColor.clearColor()
        placeholderLabel.textColor = UIColor.lightGrayColor()
        messageTextView.addSubview(placeholderLabel)
        
        
        //Setting of Profile Pic for Current User
//        if currentUser["profilePic"] != nil {
//            
//            currentUser["profilePic"].getDataInBackgroundWithBlock({
//                (imageData: NSData!, error: NSError!) -> Void in
//                
//                if error == nil {
//                    
//                    let image = UIImage(data: imageData)
//                    //self.profilePicView.image = image
//                    
//                } else {
//                    
//                    println(error)
//                    
//                }
//            })
//            
//            
//        }
        
        refreshResult()

    }
    
    func refreshResult() {
        
        let theWidth = view.frame.width
        let theHeight = view.frame.height
        
        let unitW = theWidth/37.5  //10 per unit
        let unitH = theHeight/66.7 //10 per unit
        
        messageX = 37.0
        messageY = 26.0
        
        frameX = 32.0
        frameY = 21.0
        
        imageX = 3.0
        imageY = 3.0
        
        messageArray.removeAll(keepCapacity: false)
        senderArray.removeAll(keepCapacity: false)
        
        
        let innerP1 = NSPredicate(format: "sender = %@ AND receiver = %@", currentUserID, otherUserID)
        var innerQ1 = PFQuery(className: "Message", predicate: innerP1)
        innerQ1.whereKey("itemID", equalTo: itemID)
        
        let innerP2 = NSPredicate(format: "sender = %@ AND receiver = %@", otherUserID, currentUserID)
        var innerQ2 = PFQuery(className: "Message", predicate: innerP2)
        innerQ2.whereKey("itemID", equalTo: itemID)

        var query = PFQuery.orQueryWithSubqueries([innerQ1, innerQ2])
        query.addAscendingOrder("createdAt")
        query.findObjectsInBackgroundWithBlock({
            (objects: [AnyObject]!, error: NSError!) -> Void in
            
            if error == nil {
                
                for object in objects {
                    
                    self.senderArray.append(object.objectForKey("sender") as String)
                    self.messageArray.append(object.objectForKey("message") as String)
                    
                }
                
                for subView in self.resultScrollView.subviews {
                    
                    subView.removeFromSuperview()
                    
                }
                
                for var i = 0; i <= self.messageArray.count - 1; i++ {
                    
                    if self.senderArray[i] == self.currentUserID {
                        
                        var messageLabel = UILabel()
                        messageLabel.frame = CGRectMake(0, 0, self.resultScrollView.frame.width - (unitW * 9.4), CGFloat.max)
                        messageLabel.backgroundColor = UIColor.clearColor()
                        messageLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
                        messageLabel.textAlignment = NSTextAlignment.Left
                        messageLabel.numberOfLines = 0
                        messageLabel.font = UIFont(name: "Helvetica Neuse", size: 17)
                        messageLabel.textColor = UIColor.whiteColor()
                        messageLabel.text = self.messageArray[i]
                        messageLabel.sizeToFit()
                        messageLabel.layer.zPosition = 20
                        messageLabel.frame.origin.x = (self.resultScrollView.frame.width - self.messageX) - messageLabel.frame.width
                        messageLabel.frame.origin.y = self.messageY
                        self.resultScrollView.addSubview(messageLabel)
                        self.messageY += messageLabel.frame.height + 30
                        
                        var frameLabel = UILabel()
                        frameLabel.frame.size = CGSizeMake(messageLabel.frame.width + 10, messageLabel.frame.height + 10)
                        frameLabel.frame.origin.x = (self.resultScrollView.frame.width - self.frameX) - frameLabel.frame.width
                        frameLabel.frame.origin.y = self.frameY
                        frameLabel.backgroundColor = UIColor(red: 121.0/255.0, green: 203.0/255.0, blue: 140.0/255.0, alpha: 1)
                        frameLabel.layer.cornerRadius = 10
                        frameLabel.clipsToBounds = true
                        self.resultScrollView.addSubview(frameLabel)
                        self.frameY += frameLabel.frame.height + 20
                        
                        var image = UIImageView()
                        image.image = UIImage(named: "displayPic")
                        image.frame.size = CGSizeMake(34, 34)
                        image.frame.origin.x = (self.resultScrollView.frame.width - self.imageX) - image.frame.width
                        image.frame.origin.y = self.imageY
                        image.layer.zPosition = 30
                        image.layer.cornerRadius = image.frame.width/2
                        image.clipsToBounds = true
                        self.resultScrollView.addSubview(image)
                        self.imageY += frameLabel.frame.height + 20
                        
                        self.resultScrollView.contentSize = CGSizeMake(theWidth, self.messageY)
                        
                        
                    } else {
                        
                        var messageLabel = UILabel()
                        messageLabel.frame = CGRectMake(0, 0, self.resultScrollView.frame.width - (unitW * 9.4), CGFloat.max)
                        messageLabel.backgroundColor = UIColor.clearColor()
                        messageLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
                        messageLabel.textAlignment = NSTextAlignment.Left
                        messageLabel.numberOfLines = 0
                        messageLabel.font = UIFont(name: "Helvetica Neuse", size: 17)
                        messageLabel.textColor = UIColor(red: 58.0/255.0, green: 66.0/255.0, blue: 70.0/255.0, alpha: 1)
                        messageLabel.text = self.messageArray[i]
                        messageLabel.sizeToFit()
                        messageLabel.layer.zPosition = 20
                        messageLabel.frame.origin.x = self.messageX
                        messageLabel.frame.origin.y = self.messageY
                        self.resultScrollView.addSubview(messageLabel)
                        self.messageY += messageLabel.frame.height + 30
                        
                        var frameLabel = UILabel()
                        frameLabel.frame = CGRectMake(self.frameX, self.frameY, messageLabel.frame.width + 10, messageLabel.frame.height + 10)
                        frameLabel.backgroundColor = UIColor(red: 225.0/255.0, green: 219.0/255.0, blue: 198.0/255.0, alpha: 1)
                        frameLabel.layer.cornerRadius = 10
                        frameLabel.clipsToBounds = true
                        self.resultScrollView.addSubview(frameLabel)
                        self.frameY += frameLabel.frame.height + 20
                        
                        var image = UIImageView()
                        image.image = UIImage(named: "profilePlaceholder")
                        image.frame = CGRectMake(self.imageX, self.imageY, 34, 34)
                        image.layer.zPosition = 30
                        image.layer.cornerRadius = image.frame.width/2
                        image.clipsToBounds = true
                        self.resultScrollView.addSubview(image)
                        self.imageY += frameLabel.frame.height + 20
                        
                        self.resultScrollView.contentSize = CGSizeMake(theWidth, self.messageY)
                        
                    }
                    
                    var bottomOffset: CGPoint = CGPointMake(0, self.resultScrollView.contentSize.height - self.resultScrollView.bounds.size.height)
                    self.resultScrollView.setContentOffset(bottomOffset, animated: false)
                    
                }

            }
            
        })
    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
