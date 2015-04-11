//
//  SecondViewController.swift
//  dearGod
//
//  Created by Josie Bealle on 10/04/2015.
//  Copyright (c) 2015 Josie Bealle. All rights reserved.
//

import UIKit
import QuartzCore

class AskViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var holyAsk: UILabel!
    @IBOutlet weak var askField: UITextView!
    let placeholder = "Ask His/Her Holiness Here..."
    @IBAction func buttonAction(sender: UIButton) {
        if sender == self.submitButton{
            // Submit Question to Oracle
            //sharedData.brain.sendHTTPRequest(askField.text)
            sharedData.changePoints(-10)
            self.holyAsk.text=sharedData.holyPoints
            self.textViewDidEndEditing(self.askField)
        }
        else if sender == self.cancelButton{
            self.textViewDidEndEditing(self.askField)           
            
            
        }
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.holyAsk.text=sharedData.holyPoints
        
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        textView.text = self.placeholder
        textView.textColor = UIColor.grayColor()
        textView.endEditing(true)
        
    }
    func textViewDidBeginEditing(textView: UITextView) {
        textView.text = ""
        textView.textColor = UIColor.blackColor()
        
    
    }
//    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
//        if (count(textView.text) - range.length) > 140 {
//            return true
//        }
//        return false
//        
//    }
    
    func textViewDidChange(textView: UITextView) {
        if count(textView.text) > 150 {
            let myNSString = textView.text as NSString
            let shortString = myNSString.substringWithRange(NSRange(location: 0, length: 150))
            self.askField.text = shortString as String
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = sharedData.backgroundColor
        self.holyAsk.text = sharedData.holyPoints
        self.askField.clipsToBounds = true
        self.askField.layer.cornerRadius = 10.0
        self.askField.delegate = self
        self.askField.text = self.placeholder
        self.askField.textColor = UIColor.grayColor()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}

