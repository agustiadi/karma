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
        resultScrollView.backgroundColor = UIColor.yellowColor()
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
        if currentUser["profilePic"] != nil {
            
            currentUser["profilePic"].getDataInBackgroundWithBlock({
                (imageData: NSData!, error: NSError!) -> Void in
                
                if error == nil {
                    
                    let image = UIImage(data: imageData)
                    //self.profilePicView.image = image
                    
                } else {
                    
                    println(error)
                    
                }
            })
            
            
        }
        
        refreshResult()

    }
    
    func refreshResult() {
        
        let theWidth = view.frame.width
        let theHeight = view.frame.height
        
        let unitW = theWidth/37.5  //10 per unit
        let unitH = theHeight/66.7 //10 per unit
        
        messageX = 37.0
        messageY = 26.0
        
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
