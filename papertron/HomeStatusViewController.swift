//
//  HomeStatusViewController.swift
//  papertron
//
//  Created by Matteo Comisso on 25/12/14.
//  Copyright (c) 2014 Hackatron. All rights reserved.
//

import Foundation

class HomeStatusViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Some awesome stuff
        self.downloadPapers()
    }
    
    func downloadPapers() {
        let queryPaper = PFQuery(className: "Papers")
        
        queryPaper.findObjectsInBackgroundWithBlock { (response: [AnyObject]!, error: NSError!) -> Void in
            if (error == nil) {
                if let papersObjects = response as? [PFObject] {
                    self.dataSource = papersObjects
                    self.tableView.reloadData()
                }
            }
        }
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:papersCell = tableView.dequeueReusableCellWithIdentifier("cellIdentifier") as papersCell
        
        let paperObject = self.dataSource[indexPath.row] as PFObject
        
        cell.titleLabel.text = paperObject.objectForKey("Title") as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("paperDetails", sender: self.dataSource[indexPath.row])
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "paperDetails") {
            let pdvc = segue.destinationViewController as PaperDetailsViewController
            let paperObject = sender as? PFObject

            pdvc.paperID = paperObject?.objectId as String!
        }
    }
    
}

class papersCell : UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var speakerLable: UILabel!
    
    @IBOutlet weak var voteCountLabel: UILabel!
}