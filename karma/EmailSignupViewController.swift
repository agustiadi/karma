//
//  Email Signup ViewController.swift
//  karma
//
//  Created by Agustiadi on 16/3/15.
//  Copyright (c) 2015 Agustiadi. All rights reserved.
//

import UIKit

class EmailSignupViewController: UIViewController {

    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var processingView = UIView()

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBAction func signupBtn(sender: AnyObject) {
        
        processingView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        processingView.backgroundColor = UIColor.blackColor()
        processingView.alpha = 0.8
        self.view.addSubview(processingView)
        
        startActivityIndicator()
        
        if nameField.text == "" || emailField.text == "" || passwordField.text == ""{
            self.stopActivityIndicator()
            self.processingView.removeFromSuperview()
            displayAlert("Missing Input", message: "You need to give input for all three fields")
        } else if count(passwordField.text) < 5 {
            self.stopActivityIndicator()
            self.processingView.removeFromSuperview()
            displayAlert("Password Length", message: "Please note that your password needs to consist of at least 5 characters")
        } else {
            var user = PFUser()
            user["name"] = nameField.text
            user.username = emailField.text
            user.email = emailField.text
            user.password = passwordField.text
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool, signupError: NSError!) -> Void in
                if signupError == nil {
                    self.performSegueWithIdentifier("userSignedUpViaEmail", sender: self)
                    self.stopActivityIndicator()
                } else {
                    if let errorString = signupError.userInfo?["error"] as? NSString{
                        self.stopActivityIndicator()
                        self.processingView.removeFromSuperview()
                        self.displayAlert("Error in Form", message: errorString as String)
                        
                    } else {
                        self.stopActivityIndicator()
                        self.processingView.removeFromSuperview()
                        self.displayAlert("Error", message: "Some unidentified error. Please try again!")
                    }
                    
                }
            }
        }
    }
    
    @IBAction func cancelSignup(sender: AnyObject) {
        navigationController?.popToRootViewControllerAnimated(true)

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Add padding to text input
        let paddingViewName = UIView(frame: CGRectMake(0,0,10, self.nameField.frame.height))
        nameField.leftView = paddingViewName
        nameField.leftViewMode = UITextFieldViewMode.Always
        let paddingViewEmail = UIView(frame: CGRectMake(0,0,10, self.emailField.frame.height))
        emailField.leftView = paddingViewEmail
        emailField.leftViewMode = UITextFieldViewMode.Always
        let paddingViewPassword = UIView(frame: CGRectMake(0,0,10, self.passwordField.frame.height))
        passwordField.leftView = paddingViewPassword
        passwordField.leftViewMode = UITextFieldViewMode.Always

    }
    
    override func viewWillDisappear(animated: Bool) {
        self.processingView.removeFromSuperview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Function that calls the various UIAlert
    func displayAlert(title: String, message: String){
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.view.backgroundColor = UIColor(red: 127.0/255.0, green: 132.0/255.0, blue: 118.0/255.0, alpha: 1.0)
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


