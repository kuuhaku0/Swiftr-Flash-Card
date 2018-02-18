//
//  FlashCard.swift
//  Swiftr Flash Card
//
//  Created by C4Q on 2/17/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import Foundation

class FlashCard {
    let question: String
    let answer: String
    let category: String
    let creator: String
    var correct: Bool
    
    init(question: String, answer: String, category: String, creator: String, correct: Bool) {
        self.question = question
        self.answer = answer
        self.category = category
        self.creator = creator
        self.correct = correct
    }
}

