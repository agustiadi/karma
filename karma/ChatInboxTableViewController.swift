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
    var unreadLabelArray = [Int]()
    var dateAndTimeArray = [String]()
    
    let currentUser = PFUser.currentUser()
    let currentUserID = PFUser.currentUser().objectId
    
    let placeholderImage = UIImage(named: "profilePlaceholder")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        refreshData()
    }
    
    
    func refreshData() {
        
        let predicate = NSPredicate(format: "user1 = %@ OR user2 = %@", currentUserID, currentUserID)
        var query = PFQuery(className: "Inbox", predicate: predicate)
        query.addDescendingOrder("updatedAt")
        query.findObjectsInBackgroundWithBlock({
            (objects: [AnyObject]!, error: NSError!) -> Void in
            
            self.itemIDArray.removeAll(keepCapacity: false)
            self.userIDArray.removeAll(keepCapacity: false)
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
        
        var lastCheckDateAndTime = NSDate()
        
        let item = self.itemIDArray[indexPath.row]
        let user = self.userIDArray[indexPath.row]
        
        var objectQuery = PFQuery(className: "Item")
        objectQuery.whereKey("objectId", equalTo: item)
        objectQuery.findObjectsInBackgroundWithBlock({
            (objects: [AnyObject]!, error: NSError!) -> Void in
        
            if error == nil {
        
                let object = objects[0] as! PFObject
                cell.itemName.text = object["itemName"] as? String
        
            }
                                    
        })
        
        var userQuery = PFQuery(className: "_User")
        userQuery.whereKey("objectId", equalTo: user)
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
        
        //Getting the number of unread messages
        
        let inboxP1 = NSPredicate(format: "itemID = %@ AND user1 = %@ AND user2 = %@", item, currentUserID, user)
        var inboxQ1 = PFQuery(className: "Inbox", predicate: inboxP1)
        
        let inboxP2 = NSPredicate(format: "itemID = %@ AND user1 = %@ AND user2 = %@", item, user, currentUserID)
        var inboxQ2 = PFQuery(className: "Inbox", predicate: inboxP2)
        
        var inboxQuery = PFQuery.orQueryWithSubqueries([inboxQ1, inboxQ2])
        inboxQuery.findObjectsInBackgroundWithBlock({
            (objects: [AnyObject]!, error: NSError!) -> Void in
            
            let inboxItem = objects[0] as! PFObject
            
            if inboxItem["user1"] as! String == PFUser.currentUser().objectId {
                
                if inboxItem["user1LastSeen"] != nil {
                    
                    lastCheckDateAndTime = inboxItem["user1LastSeen"] as! NSDate
                    
                } else {
                    
                    let temp = inboxItem.createdAt as NSDate
                    lastCheckDateAndTime = temp.dateByAddingTimeInterval(-60)
                }
                
            } else {
                
                if inboxItem["user2LastSeen"] != nil {
                    
                    lastCheckDateAndTime = inboxItem["user2LastSeen"] as! NSDate
                    
                } else {
                    
                    let temp = inboxItem.createdAt as NSDate
                    lastCheckDateAndTime = temp.dateByAddingTimeInterval(-60)

                }
                
            }
            
            //Getting the last message text
            
            let innerP1 = NSPredicate(format: "sender = %@ AND receiver = %@", self.currentUserID, user)
            var innerQ1 = PFQuery(className: "Message", predicate: innerP1)
            innerQ1.whereKey("itemID", equalTo: item)
            
            let innerP2 = NSPredicate(format: "sender = %@ AND receiver = %@", user, self.currentUserID)
            var innerQ2 = PFQuery(className: "Message", predicate: innerP2)
            innerQ2.whereKey("itemID", equalTo: item)
            
            var query = PFQuery.orQueryWithSubqueries([innerQ1, innerQ2])
            query.addDescendingOrder("createdAt")
            query.findObjectsInBackgroundWithBlock({
                (objects: [AnyObject]!, error: NSError!) -> Void in
                
                var unreadMessageCounter = 0
                
                if error == nil {
                    
                    let object = objects[0] as! PFObject
                    
                    var date = object.createdAt
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateStyle = .MediumStyle
                    dateFormatter.timeStyle = .ShortStyle
                    dateFormatter.timeZone = NSTimeZone.localTimeZone()
                    var dateString = dateFormatter.stringFromDate(date)
                    cell.dateAndTime.text = dateString as String
                    
                    cell.latestMessage.text = object["message"] as? String
                    
                    for object in objects {
                        
                        if object["sender"] as? String != self.currentUserID  {
                            
                            let messageCreated = object.createdAt as NSDate
                            
                            if messageCreated.compare(lastCheckDateAndTime) == NSComparisonResult.OrderedDescending {
                                
                                unreadMessageCounter++
                                
                            }
                            
                        }
                    }
                    
                    if unreadMessageCounter != 0 {
                        
                        cell.unreadLabel.text = String(unreadMessageCounter)
                        cell.unreadLabel.textColor = UIColor.whiteColor()
                        cell.unreadLabel.backgroundColor = UIColor(red: 244.0/255.0, green: 196.0/255.0, blue: 111.0/255.0, alpha: 1)
                        
                        cell.latestMessage.font = UIFont.boldSystemFontOfSize(13)
                        cell.latestMessage.textColor = UIColor.blackColor()
                        
                        
                    }
                    
                    
                    
                }
            })
            
        })
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        performSegueWithIdentifier("inboxCellPressed", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if segue.identifier == "inboxCellPressed" {
            
            let row = tableView.indexPathForSelectedRow()?.row
            let destinationVC = segue.destinationViewController as! ChatWindowViewController
            destinationVC.itemID = self.itemIDArray[row!]
            destinationVC.otherUserID = self.userIDArray[row!]
            
            
            let current_User = PFUser.currentUser()
            
            if current_User["profilePic"] != nil {
                
                current_User["profilePic"].getDataInBackgroundWithBlock({
                    (imageData: NSData!, error: NSError!) -> Void in
                    
                    if error == nil {
                        
                        let image = UIImage(data: imageData)
                        destinationVC.currentUserProfilPic = image!
                        
                    } else {
                        
                        println(error)
                        
                    }
                })
                
            } else {
                destinationVC.currentUserProfilPic = UIImage(named: "profilePlaceholder")!
            }
            
            var userQuery = PFQuery(className: "_User")
            userQuery.whereKey("objectId", equalTo: self.userIDArray[row!])
            userQuery.findObjectsInBackgroundWithBlock ({
                (objects: [AnyObject]!, error: NSError!) -> Void in
                
                let object = objects[0] as! PFObject
                
                destinationVC.otherUsername = object["name"] as! String
                destinationVC.navigationItem.title = object["name"] as? String
                
                if object["profilePic"] == nil {
                    
                    destinationVC.otherUserProfilePic = self.placeholderImage!
                    
                } else {
                    
                    let profileFile: AnyObject = object["profilePic"] as! PFFile
                    
                    (profileFile as! PFFile).getDataInBackgroundWithBlock({
                        (imageData: NSData!, error: NSError!) -> Void in
                        
                        if error == nil {
                            
                            let image = UIImage(data: imageData)
                            destinationVC.otherUserProfilePic = image!
                            
                        } else {
                            
                            println(error)
                            
                        }
                        
                    })
                    
                }
                
            })

            

            
    
            
        }
        
    }
    
    
    
    
}
