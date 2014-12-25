//
//  paperDetailsViewController.swift
//  papertron
//
//  Created by Matteo Comisso on 25/12/14.
//  Copyright (c) 2014 Hackatron. All rights reserved.
//

import Foundation

class PaperDetailsViewController : UIViewController {
    
    var paperID: NSString!
    var paperObject: PFObject!
    var currentVote: Int?
    
    @IBOutlet weak var paperIDLabel: UILabel!
    @IBOutlet weak var paperTitleLabel: UILabel!
    @IBOutlet weak var speakerNameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.paperIDLabel.text = self.paperID
        self.paperTitleLabel.text = self.paperObject["Title"] as? String
        self.descriptionTextView.text = self.paperObject["Description"] as? String
//        self.speakerNameLabel.text = "Speaker: ".stringByAppendingString(self.paperObject["test"] as String)
        
        self.loadVoteForCurrentPaper()
    }
    
    func loadVoteForCurrentPaper() {
        println(self.paperObject.description)
        
        let query = PFQuery(className: "PapersForPool")
        query.whereKey("Papers", equalTo: paperObject)
        query.limit = 1
        query.findObjectsInBackgroundWithBlock { (response: [AnyObject]!, error: NSError!) -> Void in
            if (error == nil) {
                //All good
                if let pfObjects = response as [PFObject]! {
                    self.currentVote = pfObjects[0].objectForKey("Votes") as? Int
                    self.paperIDLabel.text = "Votes: ".stringByAppendingFormat("%d", self.currentVote!)
                }
            }
            else {
                println("Something went wrong while finding objects \"PapersForPool\". Error: \(error.localizedDescription, error.localizedFailureReason)")
            }
        }
        
    }
    
    @IBAction func voteOrUnvote(sender: UIButton) {
        if (sender.titleLabel?.text == "Vote") {
            //Perform vote ++
            
        }
        else {
            //Perform vote --
        }
    }
    
}