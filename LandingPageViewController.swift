//
//  LoginViewController.swift
//  karma
//
//  Created by Agustiadi on 13/3/15.
//  Copyright (c) 2015 Agustiadi. All rights reserved.
//

import UIKit

class LandingPageViewController: UIViewController{
    
    let permissions = ["public_profile", "email"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        navigationController?.setNavigationBarHidden(true, animated:true)
        navigationController?.setToolbarHidden(true, animated: true)
        
        self.view.backgroundColor = UIColor(red: 175.0/255.0, green: 171.0/255.0, blue: 158.0/255.0, alpha: 1.0)
        
//        let bgImage = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height/2))
//        bgImage.image = UIImage(named: "landingBgImage")
//        self.view.addSubview(bgImage)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fbLogin(sender: AnyObject) {
        
            PFFacebookUtils.logInWithPermissions(permissions, { (user: PFUser!, error: NSError!) -> Void in
                if let user = user {
                    if user.isNew {
                        println("User signed up and logged in through Facebook!")
                        self.performSegueWithIdentifier("fbLoggedIn", sender: self)
                        self.saveFBUserAdditionalInfo()
                    } else {
                        println("User logged in through Facebook!")
                        self.performSegueWithIdentifier("fbLoggedIn", sender: self)
                    }
                } else {
                  println("Uh oh. The user cancelled the Facebook login.")
                  self.dismissViewControllerAnimated(true, completion: nil)
                }
            })
    }
    

    @IBAction func emailLogin(sender: AnyObject) {
        self.performSegueWithIdentifier("emailLogin", sender: self)
    }

    @IBAction func emailSignUp(sender: AnyObject) {
        self.performSegueWithIdentifier("emailSignup", sender: self)
    }
    
    func saveFBUserAdditionalInfo() {
        
        let current_user = PFUser.currentUser()
        
        //Get User's Full Name from FB
        
        FBRequestConnection.startWithGraphPath("me?fields=email,name,id", completionHandler: {(connection: FBRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
            if (result? != nil) {
                NSLog("error = \(error)")
            
                current_user["name"] = result.name
                current_user["email"] = result.email
                current_user.saveEventually()
                
            }
            
        } as FBRequestHandler)
        
        //Get User's Profile Picture from FB
        
        var fbSession = PFFacebookUtils.session()
        var accessToken = fbSession.accessTokenData.accessToken
        let url = NSURL(string: "https://graph.facebook.com/me/picture?type=large&return_ssl_resources=1&access_token="+accessToken)
        let urlRequest = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue()) { (response:NSURLResponse!, data:NSData!, error:NSError!) -> Void in
            
        let imageFile = PFFile(name: "Profile Picture", data: data)
        current_user["profilePic"] = imageFile
            current_user.saveInBackgroundWithBlock({ (success: Bool, error: NSError!) -> Void in
                
                if success == false {
                    println(error)
                } else {
                    println("saving user image successful")
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
