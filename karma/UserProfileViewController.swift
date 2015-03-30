//
//  UserProfileViewController.swift
//  karma
//
//  Created by Agustiadi on 16/3/15.
//  Copyright (c) 2015 Agustiadi. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var allView: UIView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var profilePicView: UIImageView!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var listingLabel: UILabel!
    @IBOutlet var gaveLabel: UILabel!
    @IBOutlet var receivedLabel: UILabel!
    @IBOutlet var listingNumber: UILabel!
    @IBOutlet var gaveNumber: UILabel!
    @IBOutlet var receivedNumber: UILabel!
    @IBOutlet var karmaCircle: UILabel!
    @IBOutlet var karmaLabel: UILabel!
    @IBOutlet var karmaPoints: UILabel!
    @IBOutlet var firstLineDivider: UILabel!
    @IBOutlet var aboutLabel: UILabel!
    @IBOutlet var aboutDescription: UILabel!
    @IBOutlet var secondLineDivider: UILabel!
    @IBOutlet var thankYouLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    let numberOfRows = 7
    
    let current_User = PFUser.currentUser()
    
    let logoutBtn = UIBarButtonItem()
    
    func logout(sender: AnyObject) {
        
        PFUser.logOut()
        println("Logout Successful")
        navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    @IBAction func browseBtn(sender: AnyObject) {
        self.performSegueWithIdentifier("browseListing", sender: self)
    }
    
    @IBAction func giveBtn(sender: AnyObject) {
        self.performSegueWithIdentifier("listItem2", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the vieww
        
        logoutBtn.title = "Logout"
        logoutBtn.action = "logout:"
        logoutBtn.target = self

        profilePicView.layer.cornerRadius = 50
        profilePicView.clipsToBounds = true
        profilePicView.contentMode = UIViewContentMode.ScaleAspectFill
        profilePicView.image = UIImage(named: "profilePlaceholder")
    
        usernameLabel.text = current_User["name"] as? String
        
        karmaCircle.layer.cornerRadius = 30
        karmaCircle.clipsToBounds = true
        
        aboutDescription.numberOfLines = 0
        aboutDescription.text = "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable."
        
        aboutDescription.sizeToFit()
        
        secondLineDivider.center = CGPoint(x: self.view.frame.width/2, y: aboutDescription.frame.maxY + 10)
        
        thankYouLabel.center.y = secondLineDivider.frame.maxY + 20
        
        tableView.frame = CGRectMake(10, thankYouLabel.frame.maxY + 10, self.view.frame.width - 20, CGFloat(numberOfRows * 140))
        tableView.scrollEnabled = false
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: tableView.frame.maxY + 10)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        scrollView.setContentOffset(CGPointZero, animated: true)
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        scrollView.setContentOffset(CGPointZero, animated: true)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        //navigationController?.setNavigationBarHidden(false, animated:true)
        tabBarController?.navigationItem.setHidesBackButton(true, animated: false)
        tabBarController?.navigationItem.title = "User Profile"
        tabBarController?.navigationItem.setRightBarButtonItem(logoutBtn, animated: false)

        
        self.automaticallyAdjustsScrollViewInsets = true
        

        if current_User["profilePic"] != nil {
            
            current_User["profilePic"].getDataInBackgroundWithBlock({
                (imageData: NSData!, error: NSError!) -> Void in
                
                if error == nil {
                    
                    let image = UIImage(data: imageData)
                    self.profilePicView.image = image
                    
                } else {
                    
                    println(error)
                    
                }
            })
            
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: ThankyouMessageTableViewCell = tableView.dequeueReusableCellWithIdentifier("thankyouCell", forIndexPath: indexPath) as ThankyouMessageTableViewCell
        
        cell.receiverProfilePic.image = UIImage(named: "displayPic")
        
        cell.receiverName.text = "Dominique Liu"
        cell.itemName.text = "S.Bensimon Chair"
        
        cell.thankyouMessage.text = "\"There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum.\""

        
        return cell
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
