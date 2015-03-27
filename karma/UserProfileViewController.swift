//
//  UserProfileViewController.swift
//  karma
//
//  Created by Agustiadi on 16/3/15.
//  Copyright (c) 2015 Agustiadi. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
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
    
    let current_User = PFUser.currentUser()
    
    @IBAction func logoutBtn(sender: AnyObject) {
        
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

        // Do any additional setup after loading the view.

    
        profilePicView.layer.cornerRadius = 50
        profilePicView.clipsToBounds = true
        profilePicView.contentMode = UIViewContentMode.ScaleAspectFill
        profilePicView.image = UIImage(named: "profilePlaceholder")
    
        usernameLabel.text = current_User["name"] as? String
        
        karmaCircle.layer.cornerRadius = 30
        karmaCircle.clipsToBounds = true
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        navigationController?.setNavigationBarHidden(false, animated:true)
        navigationController?.setToolbarHidden(false, animated: true)
        
        
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
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
