//
//  FirstViewController.swift
//  dearGod
//
//  Created by Josie Bealle on 10/04/2015.
//  Copyright (c) 2015 Josie Bealle. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var refreshControl:UIRefreshControl!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var holyView: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.scrollView.contentInset = UIEdgeInsetsMake(60.0, -15.0, 0.0, 0.0)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "checkWithBrainForTableContentsMethod:", name: "checkWithBrainForTableContents", object: nil);

        
        scrollView.userInteractionEnabled = true
        scrollView.scrollEnabled = true
        scrollView.contentSize = CGSizeMake(500, 1000)
        scrollView.directionalLockEnabled = true
        sharedData.brain.getAllQuestions()
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: Selector(self.refresh()), forControlEvents:.ValueChanged)
        
        
        self.scrollView.addSubview(refreshControl)
        
        
        
                

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
        sharedData.brain.getAllQuestions()
        
    }
    
    


  
    
    func checkWithBrainForTableContentsMethod(notification: NSNotification) {
        print ("dfd")
        for question in sharedData.questions{
            print(question)
            print ("\n")
            
        }

    }


}

