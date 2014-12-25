//
//  newPaperViewController.swift
//  papertron
//
//  Created by Matteo Comisso on 25/12/14.
//  Copyright (c) 2014 Hackatron. All rights reserved.
//

import Foundation

class newPaperViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func checkPaper() -> Bool {
        
        return true

    }
    
    func sendPaper() {
        if checkPaper() {
            let newPaper = PFObject(className: "Paper")
            
        }
    }
}