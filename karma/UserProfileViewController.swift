//
//  UserProfileViewController.swift
//  karma
//
//  Created by Agustiadi on 16/3/15.
//  Copyright (c) 2015 Agustiadi. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated:true)
        navigationController?.setToolbarHidden(false, animated: true)    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
