//
//  Globals.swift
//  dearGod
//
//  Created by Josie Bealle on 11/04/2015.
//  Copyright (c) 2015 Josie Bealle. All rights reserved.
//

import Foundation
import UIKit


class Singleton {
    var backgroundColor: UIColor = UIColor(red: 0.85, green: 0.85, blue: 1.0, alpha: 1.0)
    var brain: Brain = Brain()
    var holyPoints: String
    var questions: NSMutableArray = NSMutableArray()
    
    init() {
        holyPoints = brain.openFile("holyPoints", fileExtension: "txt")!

    }
    func changePoints(delta: Int){
        var newPts = sharedData.holyPoints.toInt()!+delta
        let newHolyString = String(newPts)
        brain.saveFile("holyPoints", fileExtension: "txt", newHolyString)
        self.holyPoints = newHolyString
    }

}
let sharedData = Singleton()
