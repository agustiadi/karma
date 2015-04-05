//
//  ChatViewController.swift
//  karma
//
//  Created by Agustiadi on 24/3/15.
//  Copyright (c) 2015 Agustiadi. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    
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
