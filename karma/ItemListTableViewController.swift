//
//  ItemListTableViewController.swift
//  karma
//
//  Created by Agustiadi on 15/3/15.
//  Copyright (c) 2015 Agustiadi. All rights reserved.
//

import UIKit

class ItemListTableViewController: UITableViewController {
    
    var objectIDs = [String]()
    var itemsName = [String]()
    var itemsImage = [String:UIImage]()
    var descriptions = [String]()
    var categories = [String]()
    var userIDs = [String]()
    var userName = [String:String]()
    var profilePic = [String:UIImage]()
    
    var inboxBarButtonItem = UIBarButtonItem()

    
    let placeholderFile = PFFile(data: UIImagePNGRepresentation(UIImage(named: "profilePlaceholder")))
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var processingView = UIView()
    
    
    //Toolbar Buttons
    
    @IBAction func listItemToolBarBtn(sender: AnyObject) {
        
        self.performSegueWithIdentifier("listItem", sender: self)
    }

    @IBAction func userProfileToolBarBtn(sender: AnyObject) {
        
        self.performSegueWithIdentifier("userProfile", sender: self)
        
    }
    
    func startActivityIndicator() {
        
        let navH = navigationController?.navigationBar.frame.height
        
        //Spinner Activity Indicator. Do not forget to initialize it and put a stop activity when its done.
        
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 80, 80))
        activityIndicator.center = CGPoint(x: self.processingView.frame.width/2, y: self.processingView.frame.height/2 - navH!)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.processingView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    func stopActivityIndicator(){
        
        self.processingView.removeFromSuperview()
        self.activityIndicator.stopAnimating()
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inboxBarButtonItem.image = UIImage(named: "chatIconWhite")
        inboxBarButtonItem.target = self
        inboxBarButtonItem.action = "inboxButtonPressed:"
        
        processingView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        processingView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(processingView)
        
        startActivityIndicator()
        
        refreshItemData()
        

    }
    
    func inboxButtonPressed(sender: UIBarButtonItem) {
        
        performSegueWithIdentifier("chatInbox", sender: self)
    }
    
    
    func refresherControl() {
        
        //Refresher Controller Set-Up
        refreshControl = UIRefreshControl()
        refreshControl!.attributedTitle = NSAttributedString(string: "Refreshing Your Karma")
        refreshControl!.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl!)
        
    }
    
    func refresh(send: AnyObject){
        
        startActivityIndicator()
        
        refreshItemData()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        refresherControl()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        //Navigation Bar Set-Up
        navigationController?.setNavigationBarHidden(false, animated:true)
        
        tabBarController?.navigationItem.setHidesBackButton(true, animated: false)
        tabBarController?.navigationItem.title = "Karma"
        tabBarController?.navigationItem.setRightBarButtonItem(inboxBarButtonItem, animated: false)
        
    }

    override func viewDidDisappear(animated: Bool) {
        
        //navigationController?.navigationBar.backItem?.title = ""

    }
    
    func updateTable(){
        
            self.tableView.reloadData()
    }
    
    
    func refreshItemData() {
        
        var itemQuery = PFQuery(className: "Item")
        itemQuery.addDescendingOrder("createdAt")
        itemQuery.findObjectsInBackgroundWithBlock {
            (itemObjects: [AnyObject]!, error: NSError!) -> Void in
            
            self.objectIDs.removeAll(keepCapacity: true)
            self.itemsName.removeAll(keepCapacity: true)
            self.itemsImage.removeAll(keepCapacity: true)
            self.descriptions.removeAll(keepCapacity: true)
            self.categories.removeAll(keepCapacity: true)
            self.userIDs.removeAll(keepCapacity: true)
            self.userName.removeAll(keepCapacity: true)
            self.profilePic.removeAll(keepCapacity: true)
            self.updateTable()
            
            if error == nil {
                
                for item in itemObjects {
                    
                    let objectid = item.objectId
                    
                    let userObject = item["userID"] as! PFObject
                    self.objectIDs.append(item.objectId)
                    self.userIDs.append(userObject.objectId)
                    self.itemsName.append(item["itemName"] as! String)
                    self.descriptions.append(item["itemDescription"] as! String)
                    self.categories.append(item["categories"] as! String)
                    
                        //Get Item Images
                        let itemPic = item["image_1"] as! PFFile
                        itemPic.getDataInBackgroundWithBlock{
                            (imageData: NSData!, error: NSError!) -> Void in
                            
                            if error == nil {
                                
                                let image = UIImage(data: imageData)
                                self.itemsImage[objectid] = image!
                                self.updateTable()

                            }
                        }
                        
                        var userQuery = PFQuery(className: "_User")
                        userQuery.whereKey("objectId", equalTo: userObject.objectId)
                        userQuery.findObjectsInBackgroundWithBlock({
                            (objects: [AnyObject]!, error: NSError!) -> Void in
                            
                            if error == nil {
                                
                                let selectedUser = objects[0] as! PFUser
                                let selectedUserName = selectedUser["name"] as! String
                                    
                                self.userName[objectid] = selectedUserName
                                self.updateTable()
                                
                                if let temp: AnyObject = selectedUser["profilePic"] {
                                    
                                    temp.getDataInBackgroundWithBlock({
                                        (imageData: NSData!, error: NSError!) -> Void in
                                        if error == nil {
                                            let image = UIImage(data: imageData)
                                                
                                                self.profilePic[objectid] = image!
                                                self.updateTable()
                                            
                                        } else {
                                            println(error)
                                        }
                                    })
                                    
                                } else {
                                    self.profilePic[objectid] = UIImage(named: "profilePlaceholder")
                                    self.updateTable()
                                }
                            }
                        })

                    
                }
                
                self.updateTable()
                    
               
                self.stopActivityIndicator()
            }
        }
    
        self.refreshControl?.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "item" {
            
            let row = tableView.indexPathForSelectedRow()?.row
            nameOfItem = self.itemsName[row!]
            categoryOfItem = self.categories[row!]
            descriptionOfItem = self.descriptions[row!]
            giverID = self.userIDs[row!]
            objectID = self.objectIDs[row!]
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        return objectIDs.count
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as! ItemListTableViewCell
        
        let objectid = self.objectIDs[indexPath.row]
        
        cell.itemImage.image = itemsImage[objectid]
        cell.userName.text = userName[objectid]
        cell.profilePic.image = profilePic[objectid]
        
        cell.itemName.text = self.itemsName[indexPath.row]
        cell.itemCategory.text = self.categories[indexPath.row]
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("item", sender: self)

    }

}
