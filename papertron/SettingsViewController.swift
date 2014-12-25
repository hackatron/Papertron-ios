//
//  SettingsViewController.swift
//  papertron
//
//  Created by Matteo Comisso on 24/12/14.
//  Copyright (c) 2014 Hackatron. All rights reserved.
//

import Foundation

class SettingsViewController : UIViewController, UIAlertViewDelegate {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var lastname: UILabel!
    
    
    let user = PFUser.currentUser()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.username.text = user.username
        self.email.text = user.email
        self.name.text = user.objectForKey("name") as? String
        self.lastname.text = user.objectForKey("lastname") as? String
    }
    
    
    @IBAction func changePassword(sender: AnyObject) {
        
        var previousPassword = UITextField?()
        var newPassword = UITextField?()
        var newPasswordConfirmation = UITextField?()
        
        let alertView = UIAlertController(title: "Change Password", message: "You're about to change the password", preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            if self.user.password == previousPassword?.text{
                if  newPassword?.text == newPasswordConfirmation?.text{
                    if newPassword?.text != ""{
                        self.user.password = newPassword?.text
                        self.user.saveInBackgroundWithBlock({ (success: Bool!, error: NSError!) -> Void in
                            if (success != nil) {
                                println("UserSaved")
                            }
                            else
                            {
                                println("error while saving. \(error.localizedDescription, error.localizedFailureReason)")
                            }
                        })
                        println("The new password is \(self.user.password)")
                    }
                }
            }
        })

        alertView.addAction(cancelAction)
        alertView.addAction(okAction)

        
        alertView.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
            
            textField.placeholder = "Old Password"
            textField.secureTextEntry = true
            previousPassword = textField
        }
        
        alertView.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
            
            textField.placeholder = "New Password"
            textField.secureTextEntry = true
            newPassword = textField
        }
        
        alertView.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
            textField.placeholder = "Repeat New Password"
            textField.secureTextEntry = true
            newPasswordConfirmation = textField
        }
        
        self.presentViewController(alertView, animated: true, completion: nil)
    }
    
    @IBAction func changeEmail(sender: AnyObject) {
        
    }
}

//MARK:- OK | Cancel delegates for password change
extension SettingsViewController {
    
}