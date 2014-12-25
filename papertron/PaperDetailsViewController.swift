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
    
    @IBOutlet weak var paperIDLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.paperIDLabel.text = self.paperID
        
    }
    
}