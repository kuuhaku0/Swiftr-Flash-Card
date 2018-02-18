//
//  FlashCardViewController.swift
//  Swiftr Flash Card
//
//  Created by C4Q on 2/17/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import UIKit

class FlashCardViewController: UIViewController {
    
//    init(selectedCategory: String) {
//        super.init(nibName: nil, bundle: nil)
//        self.selectedCategory = selectedCategory
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib.init(nibName: "CollectionViewCell", bundle: nil),
                                    forCellWithReuseIdentifier: "FlashCardCell")
            collectionView.isPagingEnabled = true
        }
    }
    
    @IBAction func newFlashCard(_ sender: UIBarButtonItem) {
        let destinationVC = CreateNewCardViewController()
        destinationVC.selectedCategory = self.selectedCategory
        performSegue(withIdentifier: "NewFCSegue", sender: self)
    }
    
    // Properties
    private let cellSpacing: CGFloat = 10
    private let reuseIdentifier = "FlashCardCell"
    private var flashCards = [FlashCard]()
    public var selectedCategory: String! {
        didSet {
            loadFlashCards(from: "something")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFlashCards(from: "something")
    }
    
    private func loadFlashCards(from category: String) {
        DBService.manager.getAllFlashCards(forCategory: category) { (flashCards) in
            self.flashCards = flashCards
            self.collectionView?.reloadData()
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destinationVC = segue.destination as? CreateNewCardViewController {
//            destinationVC.selectedCategory = self.selectedCategory
//        }
//    }
}

// MARK: - CollectionView Methods
extension FlashCardViewController: UICollectionViewDelegate {
    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell
        let flashCard = flashCards[indexPath.row]
        cell?.flipCard()
        if cell?.flipped == true {
            cell?.questionLabel.text = flashCard.question
        } else {
            cell?.questionLabel.text = flashCard.answer
        }
    }
}

extension FlashCardViewController: UICollectionViewDataSource {
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flashCards.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        let flashCard = flashCards[indexPath.row]
        cell.configureCell(with: flashCard)
        return cell
    }
}

extension FlashCardViewController: UICollectionViewDelegateFlowLayout {
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionViewWidth = collectionView.bounds.width
        let collectionViewHeight = collectionView.bounds.height
        
        return CGSize(width: collectionViewWidth, height: collectionViewHeight)
    }
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

