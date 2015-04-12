//
//  FirstViewController.swift
//  dearGod
//
//  Created by Josie Bealle on 10/04/2015.
//  Copyright (c) 2015 Josie Bealle. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var refreshControl:UIRefreshControl!
    
    @IBOutlet weak var holyView: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
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


}

