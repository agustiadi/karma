//
//  ChatWindowViewController.swift
//  karma
//
//  Created by Agustiadi on 6/4/15.
//  Copyright (c) 2015 Agustiadi. All rights reserved.
//

import UIKit

class ChatWindowViewController: UIViewController {
    
    var currentUserID = PFUser.currentUser().objectId
    var currentUsername = PFUser.currentUser().username
    var currentUserProfilPic = UIImage()
    
    var otherUserID = String()
    var otherUserProfilePic = UIImage()
    var otherUsername = "Test Name"
    
    @IBOutlet var resultScrollView: UIScrollView!
    @IBOutlet var frameMessageView: UIView!
    @IBOutlet var lineLabel: UILabel!
    @IBOutlet var messageTextView: UITextView!
    @IBOutlet var sendButton: UIButton!
    
    var scrollViewOriginalY: CGFloat = 0
    var frameMessageOriginalY: CGFloat = 0
    
    let placeholderLabel = UILabel(frame: CGRectMake(5, 8, 200, 20))

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let theWidth = view.frame.width
        let theHeight = view.frame.height
        let navBarY = navigationController?.navigationBar.frame.maxY

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
