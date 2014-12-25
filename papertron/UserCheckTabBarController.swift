//
//  UserCheckTabBarController.swift
//  papertron
//
//  Created by Matteo Comisso on 24/12/14.
//  Copyright (c) 2014 Hackatron. All rights reserved.
//

import Foundation

class UserCheckTabBarController : UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let user = PFUser.currentUser()
        
        if user == nil
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("register-login") as UIViewController
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }
}