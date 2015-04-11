//
//  AnswerViewController.swift
//  dearGod
//
//  Created by Josie Bealle on 11/04/2015.
//  Copyright (c) 2015 Josie Bealle. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var holyAnswer: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.holyAnswer.text=getHolyPoints()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getHolyPoints()->String{
        var comm : IosCommunicator = IosCommunicator()
        return comm.openFile("holyPoints", fileExtension: "txt")!
        
    }


    
}
