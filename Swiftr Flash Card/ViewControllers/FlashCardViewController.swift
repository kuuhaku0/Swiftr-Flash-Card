//
//  FlashCardViewController.swift
//  Swiftr Flash Card
//
//  Created by C4Q on 2/17/18.
//  Copyright © 2018 basedOnTy. All rights reserved.
//

import UIKit

class FlashCardViewController: UIViewController {
    
    // Properties
    public var selectedCategory: Category! {
        didSet {
            loadFlashCards(from: selectedCategory.name)
        }
    }
    private let cellSpacing: CGFloat = 10
    private let reuseIdentifier = "FlashCardCell"
    private var flashCards = [FlashCard]() {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    // Register nib and enable pagination for collectionView
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib.init(nibName: "CollectionViewCell", bundle: nil),
                                    forCellWithReuseIdentifier: "FlashCardCell")
            collectionView.isPagingEnabled = true
            collectionView.bounces = false
        }
    }
    @IBAction func newFlashCard(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "NewFCSegue", sender: self)
    }
    @IBOutlet weak var progressionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = selectedCategory.name
    }
    // Firebase observer
    private func loadFlashCards(from category: String) {
        DBService.manager.getAllFlashCards(forCategory: category) { (flashCards) in
            self.flashCards = flashCards.reversed()
        }
    }
    // Segue and pass selectedCategory
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? CreateNewCardViewController {
            destinationVC.selectedCategory = self.selectedCategory
        }
    }
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

// CollectionView dataSource
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

// CollectionView flow layout
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

extension FlashCardViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let midX: CGFloat = scrollView.bounds.midX
        let midY: CGFloat = scrollView.bounds.midY
        let point: CGPoint = CGPoint(x: midX, y: midY)
        guard let indexPath: IndexPath = collectionView.indexPathForItem(at: point) else {return}
        let currentIndex: Int = indexPath.item
        progressionLabel.text = "\(currentIndex + 1) / \(flashCards.count)"
    }
}

