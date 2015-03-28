//
//  ItemListTableViewController.swift
//  karma
//
//  Created by Agustiadi on 15/3/15.
//  Copyright (c) 2015 Agustiadi. All rights reserved.
//

import UIKit

class ItemListTableViewController: UITableViewController{
    
    var objectIDs = [String]()
    var itemsName = [String]()
    var itemsImage = [PFFile]()
    var descriptions = [String]()
    var categories = [String]()
    var userIDs = [String]()
    var userName = [String]()
    var userImageFile = [PFFile]()
    
    let placeholderFile = PFFile(data: UIImagePNGRepresentation(UIImage(named: "profilePlaceholder")))
    
    //Toolbar Buttons
    
    @IBAction func listItemToolBarBtn(sender: AnyObject) {
        
        self.performSegueWithIdentifier("listItem", sender: self)
    }

    @IBAction func userProfileToolBarBtn(sender: AnyObject) {
        
        self.performSegueWithIdentifier("userProfile", sender: self)
        
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshItemData()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        //Navigation Bar Set-Up
        navigationController?.setNavigationBarHidden(false, animated:true)
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        let backBtn = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backBtn

        //Toolbar Set-Up
        navigationController?.setToolbarHidden(false, animated: true)
        
    }
    
    func refreshItemData() {

        var itemQuery = PFQuery(className: "Item")
        itemQuery.addDescendingOrder("createdAt")
        itemQuery.findObjectsInBackgroundWithBlock {
            (itemObjects: [AnyObject]!, error: NSError!) -> Void in
            
            if error == nil {
                
                self.objectIDs.removeAll(keepCapacity: true)
                self.itemsName.removeAll(keepCapacity: true)
                self.itemsImage.removeAll(keepCapacity: true)
                self.descriptions.removeAll(keepCapacity: true)
                self.categories.removeAll(keepCapacity: true)
                self.userIDs.removeAll(keepCapacity: true)
                self.userName.removeAll(keepCapacity: true)
                self.userImageFile.removeAll(keepCapacity: true)
                
                for item in itemObjects {
                    
                    self.objectIDs.append(item.objectId as String)
                    self.userIDs.append(item["userId"] as String)
                    self.itemsName.append(item["itemName"] as String)
                    self.descriptions.append(item["itemDescription"] as String)
                    self.categories.append(item["categories"] as String)
                    self.itemsImage.append(item["image_1"] as PFFile)
                    
                    var userQuery = PFUser.query()
                    let objectID = item["userId"] as String
                    let selectedUser = userQuery.getObjectWithId(objectID) as PFUser
                    self.userName.append(selectedUser["name"] as String)
                    
                    if selectedUser["profilePic"] != nil {
                        
                        self.userImageFile.append(selectedUser["profilePic"] as PFFile)
                        
                    } else {
                        
                        self.userImageFile.append(self.placeholderFile as PFFile)
                    }
                    
                }
                
                self.tableView.reloadData()
            }
        }
        
        

    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "item" {
            
            let destinationVC = segue.destinationViewController as DetailedItemViewController
            let selectedRow = tableView.indexPathForSelectedRow()?.row
            
            destinationVC.nameOfItem = itemsName[selectedRow!]
            destinationVC.categoryOfItem = categories[selectedRow!]
            destinationVC.descriptionOfItem = descriptions[selectedRow!]
            destinationVC.userID = userIDs[selectedRow!]
            destinationVC.objectID = objectIDs[selectedRow!]
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as ItemListTableViewCell
        
        cell.itemName.text = itemsName[indexPath.row]
        cell.itemCategory.text = categories[indexPath.row]
        
        itemsImage[indexPath.row].getDataInBackgroundWithBlock{
            (imageData: NSData!, error: NSError!) -> Void in
            
            if error == nil {
                
                let image = UIImage(data: imageData)
                cell.itemImage.image = image
                
            } else {
                
                println(error)
                
            }
        }

        cell.userName.text = userName[indexPath.row]
        
        let temp = userImageFile[indexPath.row] as PFFile
        temp.getDataInBackgroundWithBlock{
            (imageData: NSData!, error: NSError!) -> Void in
            if error == nil {
                let image = UIImage(data: imageData)
                cell.profilePic.image = image

            } else {
                println(error)
            }
        }

        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("item", sender: self)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
