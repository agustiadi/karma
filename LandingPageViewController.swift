//
//  LoginViewController.swift
//  karma
//
//  Created by Agustiadi on 13/3/15.
//  Copyright (c) 2015 Agustiadi. All rights reserved.
//

import UIKit

class LandingPageViewController: UIViewController{
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var processingView = UIView()
    
    let permissions = ["public_profile", "email"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        navigationController?.setNavigationBarHidden(true, animated:true)
        
        self.view.backgroundColor = UIColor(red: 127.0/255.0, green: 132.0/255.0, blue: 118.0/255.0, alpha: 1.0)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.processingView.removeFromSuperview()
    }
    
    @IBAction func fbLogin(sender: AnyObject) {
        
        processingView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        processingView.backgroundColor = UIColor.blackColor()
        processingView.alpha = 0.8
        self.view.addSubview(processingView)
        
        startActivityIndicator()
        
        PFFacebookUtils.logInWithPermissions(permissions, block: { (user: PFUser!, error: NSError!) -> Void in
                if let user = user {
                    if user.isNew {
                        println("User signed up and logged in through Facebook!")
                        self.performSegueWithIdentifier("fbLoggedIn", sender: self)
                        self.saveFBUserAdditionalInfo()
                        self.stopActivityIndicator()

                    } else {
                        println("User logged in through Facebook!")
                        self.performSegueWithIdentifier("fbLoggedIn", sender: self)
                        self.stopActivityIndicator()

                    }
                } else {
                  println("Uh oh. The user cancelled the Facebook login.")
                  self.dismissViewControllerAnimated(true, completion: nil)
                    self.stopActivityIndicator()

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
            if (result != nil) {
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
    
    func startActivityIndicator() {
        
        //Spinner Activity Indicator. Do not forget to initialize it and put a stop activity when its done.
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = CGPoint(x: self.processingView.frame.width/2, y: self.processingView.frame.height/2)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        self.processingView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    func stopActivityIndicator(){
        
        self.activityIndicator.stopAnimating()
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
        
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
