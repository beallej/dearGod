//
//  AnswerViewController.swift
//  dearGod
//
//  Created by Josie Bealle on 11/04/2015.
//  Copyright (c) 2015 Josie Bealle. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var holyAnswer: UILabel!
    @IBOutlet weak var answerText: UITextView!
   
    @IBOutlet weak var passB: UIButton!
    @IBOutlet weak var submitB: UIButton!
    let placeholder = "Enter your answer here..."
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
