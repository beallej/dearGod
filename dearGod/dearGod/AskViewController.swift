//
//  SecondViewController.swift
//  dearGod
//
//  Created by Josie Bealle on 10/04/2015.
//  Copyright (c) 2015 Josie Bealle. All rights reserved.
//

import UIKit

class AskViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var holyAsk: UILabel!
    @IBOutlet weak var askField: UITextView!
    let placeholder = "Ask His/Her Holiness Here..."
    @IBAction func buttonAction(sender: UIButton) {
        if sender == self.submitButton{
            // Submit Question to Oracle
            self.textViewDidEndEditing(self.askField)
        }
        else if sender == self.cancelButton{
            
            self.textViewDidEndEditing(self.askField)           
            
            
        }
        
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        self.askField.text = self.placeholder
        self.askField.textColor = UIColor.grayColor()
        self.askField.endEditing(true)
        
    }
    func textViewDidBeginEditing(textView: UITextView) {
        textView.text = ""
        textView.textColor = UIColor.blackColor()
        
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.holyAsk.text = self.getHolyPoints()
        self.askField.delegate = self
        self.askField.text = self.placeholder
        self.askField.textColor = UIColor.grayColor()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getHolyPoints()->String{
        var comm : IosCommunicator = IosCommunicator()
        return comm.openFile("holyPoints", fileExtension: "txt")!
        
    }



}

