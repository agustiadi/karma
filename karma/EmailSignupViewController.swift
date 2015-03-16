//
//  Email Signup ViewController.swift
//  karma
//
//  Created by Agustiadi on 16/3/15.
//  Copyright (c) 2015 Agustiadi. All rights reserved.
//

import UIKit

class EmailSignupViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func signupBtn(sender: AnyObject) {
        
        if nameField.text == "" || emailField.text == "" || passwordField.text == ""{
            displayAlert("Missing Input", message: "You need to give input for all three fields")
        } else if countElements(passwordField.text) < 8 {
            displayAlert("Password Length", message: "Please note that your password needs to consist of at least 8 characters")
        } else {
            var user = PFUser()
            user["name"] = nameField.text
            user.username = emailField.text
            user.email = emailField.text
            user.password = passwordField.text
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool!, signupError: NSError!) -> Void in
                if signupError == nil {
                    self.performSegueWithIdentifier("userSignedUpViaEmail", sender: self)
                } else {
                    if let errorString = signupError.userInfo?["error"] as? NSString{
                        self.displayAlert("Error in Form", message: errorString)
                        
                    } else {
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
    
    func backToLandingPage() {

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
