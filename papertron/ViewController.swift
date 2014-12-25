//
//  ViewController.swift
//  papertron
//
//  Created by Matteo Comisso on 27/10/14.
//  Copyright (c) 2014 Hackatron. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PFSignUpViewControllerDelegate, PFLogInViewControllerDelegate {

    let user = PFUser.currentUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if (user != nil) {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func register(sender: AnyObject) {
    
        let signupController = PFSignUpViewController.alloc()
        signupController.delegate = self
        signupController.fields = PFSignUpFields.Email | PFSignUpFields.DismissButton | PFSignUpFields.UsernameAndPassword
        self.presentViewController(signupController, animated: true, completion: nil)
    }
    
    @IBAction func login(sender: AnyObject) {
        
        let loginController = PFLogInViewController.alloc()
        loginController.delegate = self
        loginController.fields = PFLogInFields.DismissButton | PFLogInFields.UsernameAndPassword
        self.presentViewController(loginController, animated: true, completion: nil)
    }
}

//MARK:- login delegates
extension ViewController {
    
    func logInViewController(logInController: PFLogInViewController!, didLogInUser user: PFUser!) {
        println("The user logged in")
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            //Notify that the user logged in
            
        })
    }
    
}

//MARK:- signup delegates
extension ViewController {
    
    func signUpViewController(signUpController: PFSignUpViewController!, didSignUpUser user: PFUser!) {
        println("Welcome to: \(user.username)")
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            //Notify that the user just registered itself

        })
    }
    
}