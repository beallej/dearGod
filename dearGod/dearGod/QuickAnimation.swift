//
//  QuickAnimation.swift
//  dearGod
//
//  Created by Thomas Redding on 4/11/15.
//  Copyright (c) 2015 Josie Bealle. All rights reserved.
//

import Foundation
import UIKit

class QuickAnimation {
    var images : [UIImage]
    
    init(imageName: String, numberOfImages: Int, fileExtension: String) {
        images = [UIImage]()
        for(var i=0; i<numberOfImages; i++) {
            let name = imageName + String(i) + fileExtension;
            images.append(UIImage(named: name)!)
        }
    }
    
    func play() {
        // TODO
    }
}