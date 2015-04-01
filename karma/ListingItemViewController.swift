//
//  ListingItemViewController.swift
//  karma
//
//  Created by Agustiadi on 16/3/15.
//  Copyright (c) 2015 Agustiadi. All rights reserved.
//

import UIKit

class ListingItemViewController: UIViewController {
    
    let submitBtn = UIBarButtonItem()
    let closeBtn = UIBarButtonItem()
    
    func submit (sender: AnyObject) {
        
    }
    
    func close (sender: AnyObject) {
        
        tabBarController?.selectedIndex = 0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        submitBtn.title = "Submit"
        submitBtn.action = "submit:"
        submitBtn.target = self
        
        closeBtn.title = "Cancel"
        closeBtn.action = "close:"
        closeBtn.target = self

    }
    
    override func viewDidDisappear(animated: Bool) {
        tabBarController?.navigationItem.setLeftBarButtonItems(nil, animated: false)
        tabBarController?.tabBar.translucent = false
        tabBarController?.tabBar.hidden = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        tabBarController?.navigationItem.title = "Give an Item"
        tabBarController?.navigationItem.setRightBarButtonItem(submitBtn, animated: false)
        tabBarController?.navigationItem.setLeftBarButtonItem(closeBtn, animated: false)
        tabBarController?.tabBar.hidden = true
        
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
