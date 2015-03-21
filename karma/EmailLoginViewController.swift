//
//  EmailLoginViewController.swift
//  karma
//
//  Created by Agustiadi on 16/3/15.
//  Copyright (c) 2015 Agustiadi. All rights reserved.
//

import UIKit

class EmailLoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func loginBtn(sender: AnyObject) {
        
        PFUser.logInWithUsernameInBackground(emailField.text, password:passwordField.text) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                println("Login successful")
                self.performSegueWithIdentifier("userLoggedInViaEmail", sender: self)
                
            } else {
                self.displayAlert("Log In Error", message: "Please make sure you input the right username and password")
            }
        }

    }
    
    @IBAction func cancelLogin(sender: AnyObject) {
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
    
    override func viewWillAppear(animated: Bool) {
        
        self.view.backgroundColor = UIColor(red: 175.0/255.0, green: 171.0/255.0, blue: 158.0/255.0, alpha: 1.0)
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
