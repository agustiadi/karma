//
//  ChatInboxTableViewController.swift
//  karma
//
//  Created by Agustiadi on 7/4/15.
//  Copyright (c) 2015 Agustiadi. All rights reserved.
//

import UIKit

class ChatInboxTableViewController: UITableViewController {
    
    var userIDArray = [String]()
    var itemIDArray = [String]()
    var latestMessageArray = [String]()
    var unreadLabelArray = [Int]()
    var dateAndTimeArray = [String]()
    
    let currentUser = PFUser.currentUser()
    let currentUserID = PFUser.currentUser().objectId
    
    let placeholderImage = UIImage(named: "profilePlaceholder")
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        let predicate = NSPredicate(format: "user1 = %@ OR user2 = %@", currentUserID, currentUserID)
        var query = PFQuery(className: "Inbox", predicate: predicate)
        query.addDescendingOrder("updatedAt")
        query.findObjectsInBackgroundWithBlock({
            (objects: [AnyObject]!, error: NSError!) -> Void in
            
            self.itemIDArray.removeAll(keepCapacity: false)
            self.userIDArray.removeAll(keepCapacity: false)
            self.latestMessageArray.removeAll(keepCapacity: false)
            self.unreadLabelArray.removeAll(keepCapacity: false)
            self.dateAndTimeArray.removeAll(keepCapacity: false)
            
            if error == nil {
                
                if objects.count == 0 {
                    
                    //set up a new label to say "Inbox is Empty"
                    
                } else {
                    
                    for object in objects {
                        
                        self.itemIDArray.append(object["itemID"] as! String)
                        
                        let user1ID = object["user1"] as! String
                        let user2ID = object["user2"] as! String
                        
                        if user1ID == self.currentUserID {
                            
                            self.userIDArray.append(user2ID)
                            
                        }
                        
                        if user2ID == self.currentUserID {
                            
                            self.userIDArray.append(user1ID)

                        }
                        
                    }
                    
                    self.tableView.reloadData()

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

        return itemIDArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ChatInboxTableViewCell = tableView.dequeueReusableCellWithIdentifier("chatCell", forIndexPath: indexPath) as! ChatInboxTableViewCell
        
        var objectQuery = PFQuery(className: "Item")
        objectQuery.whereKey("objectId", equalTo: self.itemIDArray[indexPath.row])
        objectQuery.findObjectsInBackgroundWithBlock({
            (objects: [AnyObject]!, error: NSError!) -> Void in
        
            if error == nil {
        
                let object = objects[0] as! PFObject
                cell.itemName.text = object["itemName"] as? String
        
            }
                                    
        })
        
        var userQuery = PFQuery(className: "_User")
        userQuery.whereKey("objectId", equalTo: self.userIDArray[indexPath.row])
        userQuery.findObjectsInBackgroundWithBlock ({
            (objects: [AnyObject]!, error: NSError!) -> Void in
            
            let object = objects[0] as! PFObject
            
            cell.userName.text = object["name"] as? String
            
            if object["profilePic"] == nil {
                
                cell.profilePic.image = self.placeholderImage
            
                
            } else {

                let profileFile: AnyObject = object["profilePic"] as! PFFile
                
                (profileFile as! PFFile).getDataInBackgroundWithBlock({
                    (imageData: NSData!, error: NSError!) -> Void in
                        
                        if error == nil {
                            
                            let image = UIImage(data: imageData)
                            cell.profilePic.image = image!
                            
                        } else {
                            
                            println(error)
                            
                        }
                        
                    })
                    
                }
            
        })

        return cell
    }
    

    
}

//        var query1 = PFQuery(className: "Message")
//        query1.whereKey("sender", equalTo: currentUserID)
//
//        var query2 = PFQuery(className: "Message")
//        query2.whereKey("receiver", equalTo: currentUserID)
//
//        var query = PFQuery.orQueryWithSubqueries([query1, query2])
//        query.addDescendingOrder("createdAt")
//        query.findObjectsInBackgroundWithBlock({
//            (objects: [AnyObject]!, error: NSError!) -> Void in
//
//            if error == nil {
//
//                for object in objects {
//                    //println(object)
//                }
//
//            }
//        })
