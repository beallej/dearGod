//
//  DismissAnswerSegue.swift
//  dearGod
//
//  Created by Josie Bealle on 11/04/2015.
//  Copyright (c) 2015 Josie Bealle. All rights reserved.
//

import UIKit
@objc(DismissAnswerSegue) class DismissAnswerSegue: UIStoryboardSegue {
    
    override func perform() {
        if let controller = sourceViewController.presentingViewController {
            controller!.dismissViewControllerAnimated(true, completion: nil)
        }
        
        if let controller = destinationViewController as? MainViewController {
            
        }
    }
}

