//
//  qaCell.swift
//  dearGod
//
//  Created by Josie Bealle on 28/04/2015.
//  Copyright (c) 2015 Josie Bealle. All rights reserved.
//

import UIKit

class qaCell: UITableViewCell {
    
    @IBOutlet weak var question:UITextView!
    @IBOutlet weak var answer:UITextView!
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        question.removeFromSuperview()
        question.scrollsToTop=false
        question.font = UIFont(name: "Avenir-Black", size: 16)
        question.layer.cornerRadius = 10.0
        question.layer.borderWidth = 1.0
        question.layer.borderColor = sharedData.borderColor        
        question.userInteractionEnabled = false
        question.contentInset = UIEdgeInsetsMake(-4,0,2,0);
        self.addSubview(question)
        
        answer.removeFromSuperview()
        answer.scrollsToTop=false
        answer.font = UIFont (name: "Avenir Book", size: 16)
        answer.layer.cornerRadius = 10.0
        answer.layer.borderWidth = 1.0
        answer.layer.borderColor = sharedData.borderColor
        answer.userInteractionEnabled = false
        answer.contentInset = UIEdgeInsetsMake(-4,0,2,0);
        self.addSubview(answer)
    }
    
   
    
}
