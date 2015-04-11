//
//  AnswerViewController.swift
//  dearGod
//
//  Created by Josie Bealle on 11/04/2015.
//  Copyright (c) 2015 Josie Bealle. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var holyAnswer: UILabel!
    @IBOutlet weak var answerText: UITextView!
    @IBOutlet weak var answerLabel: UILabel!
   
    @IBOutlet weak var passB: UIButton!
    @IBOutlet weak var submitB: UIButton!
    let placeholder = "Enter your answer here..."
    
    var timer = NSTimer()
    var counter = 5
    
    func counterUpdate() {
        if counter != -1{
            timeLabel.text=String(counter--)
        }
        else {
            timeLabel.text="Time's Up!"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.text = String(counter)
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("counterUpdate"), userInfo: nil, repeats: true)
        self.view.backgroundColor = sharedData.backgroundColor
        self.holyAnswer.text=getHolyPoints()
        self.answerText.delegate = self
        self.answerText.text = self.placeholder
        self.answerText.textColor = UIColor.grayColor()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func buttonAction(sender: UIButton) {
        if sender==self.submitB{
            self.textViewDidEndEditing(self.answerText)
        }
        else if sender==self.passB{
            self.textViewDidEndEditing(self.answerText)
            
        }
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getHolyPoints()->String{
        var comm : Brain = Brain()
        return comm.openFile("holyPoints", fileExtension: "txt")!
        
    }


    
}
