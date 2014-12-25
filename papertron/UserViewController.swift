//
//  UserViewController.swift
//  papertron
//
//  Created by Matteo Comisso on 24/12/14.
//  Copyright (c) 2014 Hackatron. All rights reserved.
//

import Foundation

class UserViewController : UIViewController, UITableViewDelegate {
    
    var user: PFUser?
    
    @IBOutlet weak var proposedPaperTableView: UITableView!

    override func viewDidLoad() {
        //Do something
        super.viewDidLoad()
        
        self.user = PFUser.currentUser()
        
    }
    
    func loadMyPapers() {
        let myPapersQuery = PFQuery(className: "Papers")
        
        myPapersQuery.whereKey("User", equalTo: self.user)
        myPapersQuery.findObjectsInBackgroundWithBlock { (response: [AnyObject]!, error: NSError!) -> Void in
            if (error == nil) {
                // Load all my papers
            }
        }
        
    }
    
    func loadTopPapers() {
        let topPapersQuery = PFQuery(className: "Papers")
        
        topPapersQuery.findObjectsInBackgroundWithBlock { (response: [AnyObject]!, error: NSError!) -> Void in
            if (error == nil) {
                // Load all the papers
            }
        }
    }

}

class proposedPaperCell : UITableViewCell {
    
}

class votedPaperCell : UITableViewCell {
    
}