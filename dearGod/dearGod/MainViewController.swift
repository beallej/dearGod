//
//  FirstViewController.swift
//  dearGod
//
//  Created by Josie Bealle on 10/04/2015.
//  Copyright (c) 2015 Josie Bealle. All rights reserved.
//

import UIKit
import CoreGraphics

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var refreshControl:UIRefreshControl!
    
    @IBOutlet weak var holyView: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        var question = "Man"
        var answer = "Yo mama is the best biathohfa ever don't you ever forget it"
        displayQA(question, answer:answer)
        var question2 = "Who's the prettiest girl in the world? Jesus won't you count on me? Last time I met you"
        var answer2 = "Yo mama"
        displayQA(question2, answer:answer2)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "checkWithBrainForTableContentsMethod:", name: "checkWithBrainForTableContents", object: nil);
        
        //sharedData.brain.getAllQuestions()
        self.view.backgroundColor = sharedData.backgroundColor
        self.tableView.backgroundColor = sharedData.backgroundColor
        self.tableView.contentInset = UIEdgeInsetsMake(60.0, -15.0, 0.0, 0.0)
        
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        sharedData.brain.getAllQuestions()
        for question in sharedData.questions{
            
        }
        

    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.holyView.text=sharedData.holyPoints
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh(){
        print("meow")
    }
    
    func checkWithBrainForTableContentsMethod(notification: NSNotification) {
        NSLog("Fire!");
    }
    
    var space = 70
    var lengthq = 30
    var lengtha = 30
    func displayQA(question: String, answer: String){
        var q = question
        var a = answer
        if (count(q)>40){
            lengthq = Int(count(q)/25)*30
        }
        if (count(a)>40){
            lengtha = Int(count(a)/25)*30
        }
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        var screenWidth = Int(screenSize.width)
        var questView: UITextView = UITextView (frame: CGRect(x: 10, y: space, width: screenWidth-20, height: lengthq))
        questView.font = UIFont (name: "Avenir Book", size: 18)
        self.view.addSubview(questView)
        questView.text=q
        questView.editable = false
        space += Int(lengthq + 5)
        var ansView: UITextView = UITextView (frame: CGRect(x: 10, y: space, width: screenWidth-20, height: lengtha))
        ansView.font = UIFont (name: "Avenir Book", size: 18)
        self.view.addSubview(ansView)
        ansView.text=a
        ansView.editable = false
        space += Int(lengtha + 10)
        lengthq = 30
        lengtha = 30
    }


}

