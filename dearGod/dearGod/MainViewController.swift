//
//  FirstViewController.swift
//  dearGod
//
//  Created by Josie Bealle on 10/04/2015.
//  Copyright (c) 2015 Josie Bealle. All rights reserved.
//

import UIKit
import CoreGraphics

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var refreshControl:UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var navBar: [UINavigationBar]!
    let cellIdentifier = "qaCellid"

   
    @IBOutlet weak var holyView: UILabel!
    var qList: [(String, String)]!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView?.delegate = self
        self.tableView?.dataSource = self


        self.qList=[(String, String)]()
        
        //self.tableView.contentInset = UIEdgeInsetsMake(-20.0, 0.0, 0.0, 0.0)
        

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "checkWithBrainForTableContentsMethod:", name: "checkWithBrainForTableContents", object: nil);

        
        self.tableView.userInteractionEnabled = true
        self.tableView.scrollEnabled = true
        self.tableView.contentSize = CGSizeMake(500, 1000)
        self.tableView.directionalLockEnabled = true
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: Selector(self.refresh()), forControlEvents:.ValueChanged)
        sharedData.brain.getAllQuestions()
        
        for question in sharedData.questions{
            if let quest = question["q"] as? String{
                if let ans = question["a"] as? String{
                    if !containsTuple(self.qList, tuple: (quest, ans)){
                        self.qList.append((quest, ans))
                    }
                    
                }
            }
        }

        self.tableView.reloadData()
        
        //self.scrollView.addSubview(refreshControl)
       
        
        
        

    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        sharedData.brain.getAllQuestions()
        var tempQList = [String, String]()
        for question in sharedData.questions{
            if let quest = question["q"] as? String{
                    if let ans = question["a"] as? String{
                        if !containsTuple(self.qList, tuple: (quest, ans)){
                            tempQList.append((quest, ans))
                        }
                        
                }
            }
        }
        for tuple: (String, String) in self.qList{
            tempQList.append(tuple)
        }
        self.qList = tempQList
        self.tableView.reloadData()
        //self.holyView.text=sharedData.holyPoints
        
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
        var tempQList = [String, String]()
        for question in sharedData.questions{
            if let quest = question["q"] as? String{
                    if let ans = question["a"] as? String{
                        if !containsTuple(self.qList, tuple: (quest, ans)){
                            tempQList.append((quest, ans))
                        }
                        
                    

                }
            }
        }
        for tuple: (String, String) in self.qList{
            tempQList.append(tuple)
        }
        self.qList = tempQList
        self.tableView.reloadData()
    }
    
    func containsTuple(tupleArray:[(String,String)], tuple:(String,String)) -> Bool {
        for t: (String,String) in tupleArray{
            if t.0 == tuple.0 && t.1 == tuple.1 {
                return true
            }
        }
        return false
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.qList.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier, forIndexPath: indexPath) as! qaCell
            cell.question.text = self.qList[indexPath.row].0
            cell.question.font = UIFont(name: "Avenir-Black", size: 16)
            cell.answer.text = self.qList[indexPath.row].1
            cell.answer.font = UIFont(name: "Avenir Book", size: 16)
        return cell
    }
    
   
//    var space = 40
//    var lengthq = 30
//    var lengtha = 30
//    func displayQA(question: String, answer: String){
//        var q = question
//        var a = answer
//        if (count(q)>40){
//            lengthq = Int(count(q)/25)*30
//        }
//        if (count(a)>40){
//            lengtha = Int(count(a)/25)*30
//        }
//        let screenSize: CGRect = UIScreen.mainScreen().bounds
//        var screenWidth = Int(screenSize.width)
//        var questView: UITextView = UITextView (frame: CGRect(x: 10, y: space, width: screenWidth-20, height: lengthq))
//        //var boldFont: UIFont = UIFont.preferredFontForTextStyle("bold"))
//        questView.scrollsToTop=false
//        questView.font = UIFont(name: "Avenir-Black", size: 18)
//        questView.layer.cornerRadius = 10.0
//        questView.layer.borderWidth = 1.0
//        questView.layer.borderColor = sharedData.borderColor
//        questView.userInteractionEnabled = false
//        questView.contentInset = UIEdgeInsetsMake(-4,0,2,0);
//
//        self.table.addSubview(questView)
//
//        questView.text=q
//        questView.editable = false
//        space += Int(lengthq + 5)
//        var ansView: UITextView = UITextView (frame: CGRect(x: 10, y: space, width: screenWidth-20, height: lengtha))
//        ansView.font = UIFont (name: "Avenir Book", size: 18)
//        self.tableView.addSubview(ansView)
//        ansView.text=a
//        ansView.editable = false
//        ansView.scrollsToTop=false
//        ansView.userInteractionEnabled = false
//
//        ansView.layer.cornerRadius = 10.0
//        ansView.layer.borderWidth = 1.0
//        ansView.layer.borderColor = sharedData.borderColor
//        ansView.contentInset = UIEdgeInsetsMake(-4,0,2,0);
//
//        space += Int(lengtha + 10)
//        lengthq = 30
//        lengtha = 30
//        
//        
//        self.scrollView.contentSize = CGSizeMake(CGFloat(screenWidth), CGFloat(space))
//       
//    }
//
//
}

