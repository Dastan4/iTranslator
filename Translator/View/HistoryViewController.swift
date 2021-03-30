//
//  HistoryViewController.swift
//  Translator
//
//  Created by Dastan Mambetaliev on 26/3/21.
//

import UIKit
import RealmSwift

//private let reuseIdentifier = "cell"

class HistoryViewController: UICollectionViewController {

    
    var items: Results<TranslatedItems>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(UINib(nibName: "HistoryCell", bundle: nil), forCellWithReuseIdentifier: "HistoryCell")

        items = HistoryManager.sharedInstance.getDataFromData()
    }


    // MARK: UICollectionViewDataSource


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        guard let cells = items?.count else{
            return 0
        }
        return cells
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HistoryCell", for: indexPath) as! HistoryCell
        let item: TranslatedItems = (items?.sorted(byKeyPath: "date", ascending: false)[indexPath.item])!
        cell.addText(item: item)
        return cell
    }

    // MARK: UICollectionViewFlowLayout


}

extension HistoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 20, height: CGFloat(116))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
    }
}
