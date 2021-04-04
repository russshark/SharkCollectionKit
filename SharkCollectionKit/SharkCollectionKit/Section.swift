//
//  Section.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 04/04/2021.
//

import UIKit

class Section {
    
    // MARK: - Dependencies
    
    let items: [Item]
    
    // MARK: -
    
    private var referenceCollectionView: UICollectionView?
    
    // MARK: - Init

    init(@ModelArrayBuilder<Item> items: () -> [Item]) {
        self.items = items()
    }
    
    // MARK: - Interface

    func cellItem(forIndexPath indexPath: IndexPath, collectionView: UICollectionView) -> (UICollectionViewCell, Item)? {
        self.referenceCollectionView = collectionView
        
        guard let item = items[safe: indexPath.row],
              let cell = item.binder.configure(for: collectionView, indexPath: indexPath) else { return nil }
        
        return (cell, item)
    }
    
    func numberOfItems() -> Int {
        return items.count
    }

}
