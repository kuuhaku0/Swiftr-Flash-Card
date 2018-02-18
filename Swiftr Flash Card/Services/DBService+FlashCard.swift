//
//  DBService+FlashCard.swift
//  Swiftr Flash Card
//
//  Created by C4Q on 2/17/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import Foundation
import FirebaseDatabase

extension DBService {
    public func addFlashCard(question: String, answer: String, category: String) {
        guard let currentUser = AuthUserService.getCurrentUser() else {print("could not get current user"); return}
        let ref = flashCardsRef.childByAutoId()
        let flashCard = FlashCard(question: question, answer: answer, category: category, creator: currentUser.uid, correct: false)
        ref.setValue(["question"  : flashCard.question,
                      "createdBy" : flashCard.creator,
                      "answer"    : flashCard.answer,
                      "category"  : flashCard.category,
                      "correct"   : flashCard.correct])
    }
    
    public func getCurrentUserFlashCards() -> [FlashCard] {
        guard let userId = AuthUserService.getCurrentUser()?.uid else {print("cant get current users posts"); return []}
        return flashCards.filter{ $0.creator ==  userId}
    }
    
    public func getAllFlashCards(forCategory selectedCategory: String, completion: @escaping (_ flashCards: [FlashCard]) -> Void) {
        flashCardsRef.observe(.value) { (dataSnapshot) in
            var flashCards: [FlashCard] = []
            guard let flashCardsSnapshots = dataSnapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            for flashCardSnapshot in flashCardsSnapshots {
                guard let flashCardObject = flashCardSnapshot.value as? [String: Any] else {
                    return
                }
                guard let category = flashCardObject["category"] as? String,
                    let question = flashCardObject["question"] as? String,
                    let answer = flashCardObject["answer"] as? String,
                    let creator = flashCardObject["createdBy"] as? String,
                    let correct = flashCardObject["correct"] as? Bool
                    else { print("error getting flashCards");return}
                
                if category == selectedCategory {
                    let thisFlashCard = FlashCard(question: question, answer: answer, category: category, creator: creator, correct: correct)
                    flashCards.append(thisFlashCard)
                }
            }
            DBService.manager.flashCards = flashCards
            completion(flashCards)
        }
    }
}

