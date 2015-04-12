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

    var refreshControl:UIRefreshControl!
    
    @IBOutlet var navBar: [UINavigationBar]!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var holyView: UILabel!
    var qList: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()

//        var question = "Man"
//        var answer = "Yo mama is the best biathohfa ever don't you ever forget it"
//        displayQA(question, answer:answer)
//        var question2 = "Who's the prettiest girl in the world? Jesus won't you count on me? Last time I met you"
//        var answer2 = "Yo mama"
//        displayQA(question2, answer:answer2)
        qList=[String]()
        
        self.scrollView.contentInset = UIEdgeInsetsMake(-20.0, 0.0, 0.0, 0.0)
        

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "checkWithBrainForTableContentsMethod:", name: "checkWithBrainForTableContents", object: nil);

        
        self.scrollView.userInteractionEnabled = true
        self.scrollView.scrollEnabled = true
        self.scrollView.contentSize = CGSizeMake(500, 1000)
        self.scrollView.directionalLockEnabled = true
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: Selector(self.refresh()), forControlEvents:.ValueChanged)
        var question = "Man"
        var answer = "Yo mama is the best biathohfa ever don't you ever forget it"
        //displayQA(question, answer:answer)
        var question2 = "Who's the prettiest girl in the world? Jesus won't you count on me? Last time I met you"
        var answer2 = "Yo mama"
        //displayQA(question2, answer:answer2)
        
        //self.scrollView.addSubview(refreshControl)
       
        
        
        
                

    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        sharedData.brain.getAllQuestions()
        self.holyView.text=sharedData.holyPoints
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh(){
        self.refreshControl.endRefreshing()
        sharedData.brain.getAllQuestions()
        
        
    }
    
    


  
    
    func checkWithBrainForTableContentsMethod(notification: NSNotification) {
        
        for question in sharedData.questions{
            if let quest = question["q"] as? String{
                print(quest)
                if !(contains(qList, quest)){
                    if let ans = question["a"] as? String{
                        displayQA(quest, answer:ans)
                    qList.append(quest)
                    }

                }
            }
        }

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
        //var boldFont: UIFont = UIFont.preferredFontForTextStyle("bold"))
        questView.scrollsToTop=false
        questView.font = UIFont(name: "Avenir-Black", size: 18)
        questView.layer.cornerRadius = 10.0
        questView.layer.borderWidth = 1.0
        questView.layer.borderColor = sharedData.borderColor
        questView.contentInset = UIEdgeInsetsMake(-4,0,2,0);

        self.scrollView.addSubview(questView)

        questView.text=q
        questView.editable = false
        space += Int(lengthq + 5)
        var ansView: UITextView = UITextView (frame: CGRect(x: 10, y: space, width: screenWidth-20, height: lengtha))
        ansView.font = UIFont (name: "Avenir Book", size: 18)
        self.scrollView.addSubview(ansView)
        ansView.text=a
        ansView.editable = false
        ansView.scrollsToTop=false

        ansView.layer.cornerRadius = 10.0
        ansView.layer.borderWidth = 1.0
        ansView.layer.borderColor = sharedData.borderColor
        ansView.contentInset = UIEdgeInsetsMake(-4,0,2,0);

        space += Int(lengtha + 10)
        lengthq = 30
        lengtha = 30
        
        
        
       
    }


}

