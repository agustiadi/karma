//
//  ChatInboxTableViewController.swift
//  karma
//
//  Created by Agustiadi on 7/4/15.
//  Copyright (c) 2015 Agustiadi. All rights reserved.
//

import UIKit

class ChatInboxTableViewController: UITableViewController {
    
    var profileArray = [AnyObject]()
    var userNameArray = [String]()
    var latestMessageArray = [String]()
    var unreadLabelArray = [Int]()
    var itemNameArray = [String]()
    var dateAndTimeArray = [String]()
    
    let currentUser = PFUser.currentUser()
    let currentUserID = PFUser.currentUser().objectId
    
    let placeholderImage = UIImage(named: "profilePlaceholder")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileArray.removeAll(keepCapacity: false)
        userNameArray.removeAll(keepCapacity: false)
        latestMessageArray.removeAll(keepCapacity: false)
        unreadLabelArray.removeAll(keepCapacity: false)
        itemNameArray.removeAll(keepCapacity: false)
        dateAndTimeArray.removeAll(keepCapacity: false)
    
        let predicate = NSPredicate(format: "user1 = %@ OR user2 = %@", currentUserID, currentUserID)
        var query = PFQuery(className: "Inbox", predicate: predicate)
        query.addDescendingOrder("updatedAt")
        query.findObjectsInBackgroundWithBlock({
            
            (objects: [AnyObject]!, error: NSError!) -> Void in
            
            if error == nil {
                
                if objects.count == 0 {
                    
                    //set up a new label to say "Inbox is Empty"
                    
                } else {
                    
                    for object in objects {
                        
                        let user1ID = object["user1"] as! String
                        let user2ID = object["user2"] as! String
                        
                        if user1ID == self.currentUserID {
                            
                            var userQuery = PFQuery(className: "_User")
                            userQuery.whereKey("objectId", equalTo: user2ID)
                            userQuery.findObjectsInBackgroundWithBlock({
                                (objects: [AnyObject]!, error: NSError!) -> Void in
                                
                                let object = objects[0] as! PFObject
                                
                                self.userNameArray.append(object["name"] as! String)
                                
                                if object["profilePic"] == nil {
                                    
                                    self.profileArray.append(false as Bool)
                                    
                                } else {
                                    
                                    self.profileArray.append(object["profilePic"] as! PFFile)
                                    
                                    
                                }
                                
                                
                                self.tableView.reloadData()
                            })
                        }
                        
                        
                        
                        if user2ID == self.currentUserID {
                            
                            var userQuery = PFQuery(className: "_User")
                            userQuery.whereKey("objectId", equalTo: user1ID)
                            userQuery.findObjectsInBackgroundWithBlock({
                                (objects: [AnyObject]!, error: NSError!) -> Void in
                                
                                let object = objects[0] as! PFObject
                                
                                self.userNameArray.append(object["name"] as! String)
                                
                                if object["profilePic"] == nil {
                                    
                                    self.profileArray.append(false as Bool)
                                    
                                } else {
                                    
                                    self.profileArray.append(object["profilePic"] as! PFFile)
                                    
                                }
                                
                                self.tableView.reloadData()
                                
                            })
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

        return userNameArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ChatInboxTableViewCell = tableView.dequeueReusableCellWithIdentifier("chatCell", forIndexPath: indexPath) as! ChatInboxTableViewCell
            
            let profileFile: AnyObject = self.profileArray[indexPath.row] as AnyObject
                
            if profileFile as! NSObject == false {
                
                cell.profilePic.image = self.placeholderImage
            
            } else {
                
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
            

        cell.userName.text = self.userNameArray[indexPath.row] as String
        
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
