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
        
        scrollView.userInteractionEnabled = true
        scrollView.scrollEnabled = true
        scrollView.contentSize = CGSizeMake(500, 1000)
        scrollView.directionalLockEnabled = true
       
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.scrollView.addSubview(refreshControl)
        sharedData.brain.getAllQuestions()
        for question in sharedData.questions{
            print(question[1]["q"])
            
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


}

