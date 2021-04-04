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
    
    // MARK: - Init

    init(@ModelArrayBuilder<VItem> items: () -> [VItem]) {
        self.items = items()
    }
}

extension Section: SectionT {
    
    func cellItem(forIndexPath indexPath: IndexPath, collectionView: UICollectionView) -> (UICollectionViewCell, Item)? {
        
        guard var item = items[safe: indexPath.row] else { return nil }
        item.parent = collectionView
        
        guard let cell = item.binder.configure(for: collectionView, indexPath: indexPath) else { return nil }
        
        let widthId = "cell.width"
        cell.contentView.removeConstraints(cell.contentView.constraints.filter({ $0.identifier == widthId }))
        cell.contentView.widthAnchor.constraint(equalToConstant: collectionView.bounds.inset(by: collectionView.contentInset).width).with({
            $0.priority = UILayoutPriority(999)
            $0.isActive = true
            $0.identifier = widthId
        })
   
        return (cell, item)
    }
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func size(forRow row: Int, collectionView: UICollectionView) -> CGSize {
        guard let item = items[safe: row] else { return .zero }
        let width = collectionView.bounds.inset(by: collectionView.contentInset).width
        return CGSize(width: width, height: item.estimatedHeight)
    }
}
