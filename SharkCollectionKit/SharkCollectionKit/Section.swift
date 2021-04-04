//
//  Section.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 04/04/2021.
//

import UIKit

protocol SectionT {
    func cellItem(forIndexPath indexPath: IndexPath, collectionView: UICollectionView) -> (UICollectionViewCell, Item)?
    func numberOfItems() -> Int
    func size(forRow row: Int, collectionView: UICollectionView) -> CGSize 
}

class Section {
    
    // MARK: - Dependencies
    
    let items: [VItem]
    
    // MARK: -
    
    private var referenceCollectionView: UICollectionView?
    
    // MARK: - Init

    init(@ModelArrayBuilder<VItem> items: () -> [VItem]) {
        self.items = items()
    }

}

extension Section: SectionT {
    
    func cellItem(forIndexPath indexPath: IndexPath, collectionView: UICollectionView) -> (UICollectionViewCell, Item)? {
        self.referenceCollectionView = collectionView
        
        guard let item = items[safe: indexPath.row],
              let cell = item.binder.configure(for: collectionView, indexPath: indexPath) else { return nil }
        
        return (cell, item)
    }
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func size(forRow row: Int, collectionView: UICollectionView) -> CGSize {
        
        referenceCollectionView = collectionView
        
        guard let item = items[safe: row], let collectionView = referenceCollectionView else { return .zero }
        let width = collectionView.bounds.inset(by: collectionView.contentInset).width
        return CGSize(width: width, height: item.estimatedHeight)
    }
}
