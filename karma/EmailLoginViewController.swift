//
//  EmailLoginViewController.swift
//  karma
//
//  Created by Agustiadi on 16/3/15.
//  Copyright (c) 2015 Agustiadi. All rights reserved.
//

import UIKit

class EmailLoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var copyrightText: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var divider: UIView!
    @IBOutlet weak var logoText: UILabel!
    @IBOutlet weak var quoterText: UILabel!
    @IBOutlet weak var quoteText: UILabel!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var processingView = UIView()
    
    var viewOriginalY: CGFloat = 0

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func loginBtn(sender: AnyObject) {
        
        processingView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        processingView.backgroundColor = UIColor.blackColor()
        processingView.alpha = 0.8
        self.view.addSubview(processingView)
        
        startActivityIndicator()
        
        PFUser.logInWithUsernameInBackground(emailField.text, password:passwordField.text) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                println("Login successful")
                self.performSegueWithIdentifier("userLoggedInViaEmail", sender: self)
                self.stopActivityIndicator()
                
            } else {
                self.stopActivityIndicator()
                self.processingView.removeFromSuperview()
                self.displayAlert("Log In Error", message: "Please make sure you input the right username and password")
            }
        }
        

    }
    
    func keyboardWasShown(notification: NSNotification){
        
        let dict: NSDictionary = notification.userInfo!
        let s: NSValue = dict.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let rect: CGRect = s.CGRectValue()
        
        UIView.animateWithDuration(0.01, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
                
                self.view.frame.origin.y = self.viewOriginalY - rect.height
            
            }, completion: {
                (finished: Bool) in
        })
    }
    
    
    func keyboardWillHide(notification: NSNotification){
        
        let dict: NSDictionary = notification.userInfo!
        let s: NSValue = dict.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let rect: CGRect = s.CGRectValue()
        
        UIView.animateWithDuration(0.01, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
            
            self.view.frame.origin.y = self.viewOriginalY
            
            }, completion: {
                (finished: Bool) in
        })
        
        
    }
    
    @IBAction func cancelLogin(sender: AnyObject) {
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeLayout()
        
        self.emailField.delegate = self
        self.passwordField.delegate = self
        
        let tapViewGesture = UITapGestureRecognizer(target: self, action: "didTapView")
        tapViewGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapViewGesture)
    

        // Do any additional setup after loading the view.
        // Add padding to text input
        let paddingViewEmail = UIView(frame: CGRectMake(0,0,10, self.emailField.frame.height))
        emailField.leftView = paddingViewEmail
        emailField.leftViewMode = UITextFieldViewMode.Always
        let paddingViewPassword = UIView(frame: CGRectMake(0,0,10, self.passwordField.frame.height))
        passwordField.leftView = paddingViewPassword
        passwordField.leftViewMode = UITextFieldViewMode.Always
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.processingView.removeFromSuperview()
    }
    
    func didTapView() {
        
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
        navigationController?.navigationBarHidden = true
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
    
    func makeLayout(){
        let viewWidth = view.frame.width
        let viewHeight = view.frame.height
        let viewWidthUnit = viewWidth/20
        let viewHeightUnit = viewHeight/20
        
        // Logo + Quote + backButton
        logoText.frame = CGRectMake(0, 0, viewWidth*0.5, 50)
        logoText.center = CGPointMake(viewWidth/2, viewHeightUnit*3.4)
        quoteText.frame = CGRectMake(0, 0, viewWidth*0.9, 60)
        quoteText.center = CGPointMake(viewWidth/2, viewHeightUnit*5.77)
        quoterText.frame = CGRectMake(0, 0, viewWidth*0.8, 25)
        quoterText.center = CGPointMake(viewWidth/2, viewHeightUnit*5.77+60)
        
        // Copyright
        copyrightText.frame = CGRectMake(0, viewHeight-22, viewWidth, 21)
        
        // Buttons
        loginButton.frame = CGRectMake(0, 0, viewWidth*0.64, viewWidth*0.13125)
        loginButton.center = CGPointMake(viewWidth/2, viewHeight-(viewHeightUnit*3.3))
        passwordField.frame = CGRectMake(0, 0, viewWidth*0.64, viewWidth*0.13125)
        passwordField.center = CGPointMake(viewWidth/2, viewHeight-(viewHeightUnit*4.3)-(viewWidth*0.13125))
        emailField.frame = CGRectMake(0, 0, viewWidth*0.64, viewWidth*0.13125)
        emailField.center = CGPointMake(viewWidth/2, viewHeight-(viewHeightUnit*4.6)-(viewWidth*0.2625))
        divider.frame = CGRectMake(0, 0, viewWidth*0.64, 1)
        divider.center = CGPointMake(viewWidth/2, viewHeight-(viewHeightUnit*5.1)-(viewWidth*0.328125))
        
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
