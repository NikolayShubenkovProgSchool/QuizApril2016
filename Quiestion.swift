//
//  Quiestion.swift
//  Quiz
//
//  Created by Nikolay Shubenkov on 09/04/16.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import UIKit

struct Question {
    
    let question:String
    let answers:[String]
    let correctAnswer:String
    let imageName:String
    
    init(json:[String:AnyObject]) {
        
        question = json["question"] as! String
        answers  = json["answers"]  as! [String]
        correctAnswer = json["correctAnswer"] as! String
        imageName = json["image"] as! String
    }
}
