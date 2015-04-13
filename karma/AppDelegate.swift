    //
//  AppDelegate.swift
//  karma
//
//  Created by Agustiadi on 12/3/15.
//  Copyright (c) 2015 Agustiadi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var backBtn = UIBarButtonItem()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        //Parse Set-Up Information
        Parse.setApplicationId("EMWyf0nZRZ18BDq8pKuoTArkjL876wwFZPvm0KEM", clientKey: "m7gf9uXwiIMAIM2YChJEVkIk1YMCiQfCzz6GvmsV")
        
        //Parse FB Initialization
        PFFacebookUtils.initializeFacebook()
        
        //Navigation Controller Set-Up
        UINavigationBar.appearance().barTintColor = UIColor(red: 127.0/255.0, green: 132.0/255.0, blue: 118.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        

        //Toolbar Set-Up
        UITabBar.appearance().barTintColor = UIColor(red: 127.0/255.0, green: 132.0/255.0, blue: 118.0/255.0, alpha: 1.0)
        UITabBar.appearance().tintColor = UIColor(red: 244.0/255.0, green: 196.0/255.0, blue: 111.0/255.0, alpha: 1.0)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: 244.0/255.0, green: 196.0/255.0, blue: 111.0/255.0, alpha: 1.0)], forState: UIControlState.Selected)
        

        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
            return FBAppCall.handleOpenURL(url, sourceApplication:sourceApplication, withSession:PFFacebookUtils.session())
    }
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }


    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        FBAppCall.handleDidBecomeActiveWithSession(PFFacebookUtils.session())
    }


}

