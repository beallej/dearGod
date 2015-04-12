//
//  AnswerViewController.swift
//  dearGod
//
//  Created by Josie Bealle on 11/04/2015.
//  Copyright (c) 2015 Josie Bealle. All rights reserved.
//

import UIKit
import QuartzCore

class AnswerViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var holyAnswer: UILabel!
    @IBOutlet weak var answerText: UITextView!
   
    @IBOutlet weak var passB: UIButton!
    @IBOutlet weak var submitB: UIButton!
    let placeholder = "Enter your answer here..."
    let questionID = "60"
    
    var timer = NSTimer()
    var counter = 60
    
    // 0 = no; 1 = waiting for server; 2 = yes
    var hasQuestionToAnswer = 0
    
    func counterUpdate() {
        if counter > -1{
            timeLabel.text="Time: "+String(counter--)
        }
        else if counter == -1 {
            
            self.delay(0.5){
                self.view.backgroundColor = UIColor.blackColor()
                self.timeLabel.textColor = sharedData.backgroundColor
                self.timeLabel.text="Time's Up!"
                self.hasQuestionToAnswer = 0;
            }
            counter--
        }
        else{
            //self.view.backgroundColor=sharedData.backgroundColor
            self.view.backgroundColor=UIColor.whiteColor()
            self.timeLabel.textColor=UIColor.blackColor()
            performSegueWithIdentifier("DismissAnswerSegueID", sender: self)
        }
    }
    
    //http://stackoverflow.com/questions/24034544/dispatch-after-gcd-in-swift
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = sharedData.backgroundColor
        timeLabel.text = "Time "+String(counter)
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("counterUpdate"), userInfo: nil, repeats: true)
        self.answerText.delegate = self
        self.answerText.text = self.placeholder
        self.answerText.textColor = UIColor.grayColor()
        self.answerText.clipsToBounds = true
        self.answerText.layer.cornerRadius = 10.0
        self.answerText.layer.borderWidth = 1.0
        self.answerText.layer.borderColor = sharedData.borderColor
        self.answerText.contentInset = UIEdgeInsetsMake(4,8,0,0)
        self.answerText.editable = false
        self.questionLabel.text="Waiting for Questions..."
        self.submitB.layer.cornerRadius = 10.0
        self.passB.layer.cornerRadius = 10.0
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "checkWithBrainForQuestionToAnswerMethod:", name: "checkWithBrainForQuestionToAnswer", object: nil);
    }
    
    func checkWithBrainForQuestionToAnswerMethod(notification: NSNotification) {
        self.questionLabel.text=sharedData.questionToAnswer
        self.answerText.editable = true
        self.hasQuestionToAnswer = 2
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //self.holyAnswer.text=sharedData.holyPoints
        
        // Do any additional setup after loading the view, typically from a nib.
        if(self.hasQuestionToAnswer == 0) {
            // ask brain for question to answer
            self.hasQuestionToAnswer = 1
            
            sharedData.brain.getQuestionToAnswer()
        }
    }
    
    @IBAction func buttonAction(sender: UIButton) {
        if sender==self.submitB{
            timer.invalidate()
            sharedData.changePoints(10)
            //self.holyAnswer.text=sharedData.holyPoints
            let answer = self.answerText.text
            let whitespaceSet = NSCharacterSet.whitespaceCharacterSet()
            if answer.stringByTrimmingCharactersInSet(whitespaceSet) != "" {
                sharedData.brain.answerQuestion(sharedData.questionToAnswerID, answer: answer)
                
            }
            
            
            self.textViewDidEndEditing(self.answerText)
            performSegueWithIdentifier("DismissAnswerSegueID", sender: self)

        }
        else if sender==self.passB{
            self.textViewDidEndEditing(self.answerText)
            performSegueWithIdentifier("DismissAnswerSegueID", sender: self)

            
        }
    }
    func textViewDidEndEditing(textView: UITextView) {
        self.answerText.text = self.placeholder
        self.answerText.textColor = UIColor.grayColor()
        self.answerText.endEditing(true)
        
    }
    func textViewDidBeginEditing(textView: UITextView) {
        self.answerText.text = ""
        self.answerText.textColor = UIColor.blackColor()
        self.timer.invalidate()
        self.timeLabel.text=" "
        
        
    }
    func textViewDidChange(textView: UITextView) {
        if count(textView.text) > 200 {
            let myNSString = textView.text as NSString
            let shortString = myNSString.substringWithRange(NSRange(location: 0, length: 200))
            self.answerText.text = shortString as String
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
}
