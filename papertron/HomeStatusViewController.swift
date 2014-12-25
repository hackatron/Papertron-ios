//
//  HomeStatusViewController.swift
//  papertron
//
//  Created by Matteo Comisso on 25/12/14.
//  Copyright (c) 2014 Hackatron. All rights reserved.
//

import Foundation

// Class for tableview in this viewController
class papersCell : UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var speakerLable: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
}

class HomeStatusViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {

    //Outlets and variables
    @IBOutlet weak var tableView: UITableView!
    var dataSource = [PFObject]()
    
    //MARK:- Standard view methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.downloadPapers()
    }
    
    // Downloads the papers from the Parse Backend.
    func downloadPapers() {
        //Create a query for the Table "Papers"
        let queryPaper = PFQuery(className: "Papers")

        // Performs the query online, fetching all the objects
        let papersFound = queryPaper.findObjects() as NSArray
        
        //Pins all the previously fetched objects inside the localDataStorage
        PFObject.pinAllInBackground(papersFound, block: { (success: Bool, error: NSError!) -> Void in
            if success {
                println("Objects successfully pinned in local datastorage")
            }
        })
        
        //Points the query to localDataStorage
        queryPaper.fromLocalDatastore()
        
        //Finds the objects for the tableview, looking inside the previously saved data
        queryPaper.findObjectsInBackgroundWithBlock { (response: [AnyObject]!, error: NSError!) -> Void in
            if (error == nil) {
                if let papersObjects = response as? [PFObject] {
                    self.dataSource = papersObjects
                    self.tableView.reloadData()
                }
            }
        }
    }

}

//MARK:- TABLEVIEW DELEGATE METHODS
extension HomeStatusViewController {
    
    
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

        //Takes the user of the current paper and fetches its informations, updating the view
        var speaker = paperObject.objectForKey("User") as? PFUser
        speaker?.fetchInBackgroundWithBlock({ (userData: PFObject!, error: NSError!) -> Void in
            if (error == nil) {
                println(speaker?.description)
                cell.speakerLable.text = "Speaker: ".stringByAppendingString(speaker?.username as String!)
            }
        })
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("paperDetails", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "paperDetails") {
            let pdvc = segue.destinationViewController as PaperDetailsViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            let paperObject = self.dataSource[indexPath?.row as Int!]
            pdvc.paperObject = paperObject
            pdvc.paperID = paperObject.objectId as String!
        }
    }
    
}