//
//  ChatViewController.swift
//  karma
//
//  Created by Agustiadi on 24/3/15.
//  Copyright (c) 2015 Agustiadi. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    let vc = UserProfileViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //println(vc.userProfilePic)
        
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
