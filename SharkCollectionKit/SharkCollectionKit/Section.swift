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
    
    let items: [Item]
    
    // MARK: - Init

    init(@GenericArrayBuilder<Item> items: () -> [Item]) {
        self.items = items()
    }
}

extension Section: SectionT {
    
    func cellItem(forIndexPath indexPath: IndexPath, collectionView: UICollectionView) -> (UICollectionViewCell, Item)? {
        
        guard let item = items[safe: indexPath.row]?.with({ $0.parent = collectionView }) else { return nil }
    
        guard let cell = item.binder.configure(for: collectionView, indexPath: indexPath) else { return nil }
        
        setSize(cell: cell, indexPath: indexPath, collectionView: collectionView)

        return (cell, item)
    }
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func size(forRow row: Int, collectionView: UICollectionView) -> CGSize {
        guard let item = items[safe: row] else { return .zero }
        
        if let vitem = item as? VItem {
            let width = collectionView.bounds.inset(by: collectionView.contentInset).width
            return CGSize(width: width, height: vitem.estimatedHeight)
        } else if let hitem = item as? HItem {
            return hitem.size
        } else {
            return .zero
        }
    }
    
    // MARK: -
    
    private func setSize(cell: UICollectionViewCell, indexPath: IndexPath, collectionView: UICollectionView){
        
        guard let item = items[safe: indexPath.row] else { return}
        
        let widthId = "cell.width"
        let heightId = "cell.height"
        
        NSLayoutConstraint.deactivate(cell.contentView.constraints.filter({ $0.identifier == widthId }))
        NSLayoutConstraint.deactivate(cell.contentView.constraints.filter({ $0.identifier == heightId }))
        
        if let _ = item as? VItem {
            
            cell.contentView.widthAnchor.constraint(equalToConstant: size(forRow: indexPath.row, collectionView: collectionView).width).with({
                $0.priority = UILayoutPriority(999)
                $0.isActive = true
                $0.identifier = widthId
            })
            
        } else if let _ = item as? HItem {
            
            let itemSize = size(forRow: indexPath.row, collectionView: collectionView)
            
            cell.contentView.widthAnchor.constraint(equalToConstant: itemSize.width).with({
                $0.priority = UILayoutPriority(999)
                $0.isActive = true
                $0.identifier = widthId
            })
            
            cell.contentView.heightAnchor.constraint(equalToConstant: itemSize.height).with({
                $0.priority = UILayoutPriority(999)
                $0.isActive = true
                $0.identifier = heightId
            })
        }
    }
}
