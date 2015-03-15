//
//  LoginViewController.swift
//  karma
//
//  Created by Agustiadi on 13/3/15.
//  Copyright (c) 2015 Agustiadi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var permissions = ["public_profile", "email"]
    
    @IBAction func FBLoginBtn(sender: AnyObject) {
        
        PFFacebookUtils.logInWithPermissions(permissions, {
            (user: PFUser!, error: NSError!) -> Void in
            if let user = user {
                
                if user.isNew {
                    println("User signed up and logged in through Facebook!")
                    self.performSegueWithIdentifier("userLoggedIn", sender: self)
                    
                } else {
                    println("User logged in through Facebook!")
                    self.performSegueWithIdentifier("userLoggedIn", sender: self)
                }
            } else {
                println("Uh oh. The user cancelled the Facebook login.")
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        if PFUser.currentUser() != nil {
            self.performSegueWithIdentifier("userLoggedIn", sender: self)
        }
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
