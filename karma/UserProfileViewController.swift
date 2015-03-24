//
//  UserProfileViewController.swift
//  karma
//
//  Created by Agustiadi on 16/3/15.
//  Copyright (c) 2015 Agustiadi. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    var profilePicView = UIImageView()
    var userProfilePic = UIImage()
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
        
        let scrollView = UIScrollView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        
        profilePicView = UIImageView(frame: CGRectMake(15, 10, 50, 50))
        profilePicView.layer.cornerRadius = 25
        profilePicView.clipsToBounds = true
        profilePicView.contentMode = UIViewContentMode.ScaleAspectFill
        profilePicView.image = UIImage(named: "profilePlaceholder")
        
    
        let usernameLabel = UILabel(frame: CGRectMake(80, 10, 200, 50))
        usernameLabel.text = current_User["name"] as? String
        
        view.addSubview(scrollView)
        scrollView.addSubview(profilePicView)
        scrollView.addSubview(usernameLabel)
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
                    self.userProfilePic = image!
                    
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
