//
//  SecondViewController.swift
//  dearGod
//
//  Created by Josie Bealle on 10/04/2015.
//  Copyright (c) 2015 Josie Bealle. All rights reserved.
//

import UIKit

class AskViewController: UIViewController {

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var askField: UITextView!
    let placeholder = "Ask His/Her Holiness Here..."
    @IBAction func buttonAction(sender: UIButton) {
        if sender == self.submitButton{
            // Submit Question to Oracle
        }
        else if sender == self.cancelButton{
            self.askField.text == self.placeholder
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

