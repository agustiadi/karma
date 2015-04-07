//
//  ChatInboxTableViewController.swift
//  karma
//
//  Created by Agustiadi on 7/4/15.
//  Copyright (c) 2015 Agustiadi. All rights reserved.
//

import UIKit

class ChatInboxTableViewController: UITableViewController {
    
    var profileArray = [PFFile]()
    var userNameArray = [String]()
    var latestMessageArray = [String]()
    var unreadLabelArray = [Int]()
    var itemNameArray = [String]()
    var dateAndTimeArray = [String]()
    
    let currentUser = PFUser.currentUser()
    let currentUserID = PFUser.currentUser().objectId


    override func viewDidLoad() {
        super.viewDidLoad()
        
        var query1 = PFQuery(className: "Message")
        query1.whereKey("sender", equalTo: currentUserID)
        
        var query2 = PFQuery(className: "Message")
        query2.whereKey("receiver", equalTo: currentUserID)
        
        var query = PFQuery.orQueryWithSubqueries([query1, query2])
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackgroundWithBlock({
            (objects: [AnyObject]!, error: NSError!) -> Void in
            
            if error == nil {
                
                for object in objects {
                    println(object)
                }
                
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 5
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ChatInboxTableViewCell = tableView.dequeueReusableCellWithIdentifier("chatCell", forIndexPath: indexPath) as ChatInboxTableViewCell
        
        cell.profilePic.image = UIImage(named: "displayPic")
        
        return cell
    }
    

    
}
