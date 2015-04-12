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
            sharedData.changePoints(-10)
            //self.holyAsk.text=sharedData.holyPoints
            let question = self.askField.text
            self.textViewDidEndEditing(self.askField)
            let whitespaceSet = NSCharacterSet.whitespaceCharacterSet()
            if question.stringByTrimmingCharactersInSet(whitespaceSet) != "" {
                sharedData.brain.askQuestion(question)
            }
            
            

        }
        else if sender == self.cancelButton{
            self.textViewDidEndEditing(self.askField)           
            
            
        }
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //self.holyAsk.text=sharedData.holyPoints
        
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
    

    
    func textViewDidChange(textView: UITextView) {
        if count(textView.text) > 150 {
            let myNSString = textView.text as NSString
            let shortString = myNSString.substringWithRange(NSRange(location: 0, length: 150))
            self.askField.text = shortString as String
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.holyAsk.text = sharedData.holyPoints
        self.askField.clipsToBounds = true
        self.askField.layer.cornerRadius = 10.0
        self.askField.delegate = self
        self.askField.text = self.placeholder
        self.askField.textColor = UIColor.grayColor()
        self.askField.layer.cornerRadius = 10.0
        self.askField.layer.borderWidth = 1.0
        self.askField.layer.borderColor = sharedData.borderColor
        self.askField.contentInset = UIEdgeInsetsMake(4,8,0,0);
        self.submitButton.layer.cornerRadius = 10.0
        self.cancelButton.layer.cornerRadius = 10.0
        


        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}

