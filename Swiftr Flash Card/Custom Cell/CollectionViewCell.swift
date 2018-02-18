//
//  CollectionViewCell.swift
//  Swiftr Flash Card
//
//  Created by C4Q on 2/17/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var answerView: UIView!
    @IBOutlet weak var answerLabel: UILabel!
    
    public var flipped = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        questionView.layer.cornerRadius = 15
        questionView.layer.borderWidth = 5
        questionView.layer.borderColor = UIColor(displayP3Red: 239/255, green: 238/255, blue: 202/255, alpha: 1).cgColor
    }
    
    public func flipCard() {
        
        if flipped == false{
            UIView.transition(with: questionView, duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: {(flipped) in self.flipped = false })
        } else {
            UIView.transition(with: questionView, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: {(flipped) in self.flipped = false })
        }
    }
}
