//
//  newPaperViewController.swift
//  papertron
//
//  Created by Matteo Comisso on 25/12/14.
//  Copyright (c) 2014 Hackatron. All rights reserved.
//

import Foundation

class newPaperViewController : UIViewController, UIAlertViewDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var additionalInfo1TextField: UITextField!
    
    var canBeSent: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    //Check if the paper data is acceptable
    func checkPaper() -> Bool {
        
        return true
    }
    
    func sendPaper() {
        //If the paper have all the data correctly set
        if checkPaper() {
            let newPaper = PFObject(className: "Paper")
            newPaper.setObject(PFUser.currentUser(), forKey: "User")
            
        }
    }
    
    @IBAction func sendToPapertron(sender: AnyObject) {
        let confirmationCheck = UIAlertController(title: "Sending", message: "The new paper will be submitted", preferredStyle: UIAlertControllerStyle.Alert)
        confirmationCheck.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        confirmationCheck.addAction(UIAlertAction(title: "Send", style: UIAlertActionStyle.Default, handler: { (alertAction: UIAlertAction!) -> Void in
            println("the paper is sent!")
            self.sendPaper()
        }))
    }
    
}