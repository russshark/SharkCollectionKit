//
//  Section.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 04/04/2021.
//

import UIKit

protocol SectionT {
    func cellFor(forIndexPath indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell?
    func numberOfItems() -> Int
    func size(forRow row: Int, collectionView: UICollectionView) -> CGSize
    
    func lineSpacing() -> CGFloat
    func columnSpacing() -> CGFloat
    func sectionInset() -> UIEdgeInsets
}

final class Section {
    
    // MARK: - Properties
    
    private var itemLineSpacing: CGFloat = .zero
    private var interitemSpacing: CGFloat = .zero
    private var numberOfColumns: Int = 1
    private var inset: UIEdgeInsets = .zero
    private var isGrid: Bool = false
    var collectionView: UICollectionView?
    
    // MARK: - Dependencies
    
    let items: [Item]
    
    // MARK: - Init

    init(@GenericArrayBuilder<Item> items: () -> [Item]) {
        self.items = items()
        self.interitemSpacing = .zero
        self.interitemSpacing = .zero
        self.inset = .zero
        self.numberOfColumns = 1
    }
    
    // MARK: - Chaining
    
    @discardableResult
    func lineSpacing(_ spacing: CGFloat) -> Self {
        self.itemLineSpacing = spacing
        return self
    }
    
    @discardableResult
    func columnSpacing(_ spacing: CGFloat) -> Self {
        self.interitemSpacing = spacing
        return self
    }
    
    @discardableResult
    func columns(_ numberOfColumns: Int) -> Self {
        if numberOfColumns <= 0 { assertionFailure("Columns cannot be less than 1") }
        self.numberOfColumns = numberOfColumns
        return self
    }
    
    @discardableResult
    func inset(_ inset: UIEdgeInsets) -> Self {
        self.inset = inset
        return self
    }
    
    @discardableResult
    func isGrid(_ value: Bool) -> Self {
        self.isGrid = value
        return self
    }
}

extension Section: SectionT {

    // MARK: - Config
    
    func cellFor(forIndexPath indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell? {
        
        self.collectionView = collectionView
        
        var _item = items[safe: indexPath.row]
        _item?.parentSection = self
        
        guard let item = _item,
              let cell = item.binder.configure(for: collectionView, indexPath: indexPath) else { return nil }
            
        setSize(cell: cell, indexPath: indexPath, collectionView: collectionView)

        return cell
    }
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    // MARK: - Sizing
    
    func lineSpacing() -> CGFloat {
        guard numberOfColumns == 1 else { return itemLineSpacing }
        
        // Not sure why 1.5 gives the desired result when using multi columns, needs investigation.
        return (itemLineSpacing * 1.5) + 0.82
    }
    
    func columnSpacing() -> CGFloat {
        return interitemSpacing
    }
    
    func size(forRow row: Int, collectionView: UICollectionView) -> CGSize {
        guard let item = items[safe: row] else { return .zero }
        
        if (((item as? PagerItem) != nil) || ((item as? HorizontalItem) != nil))  && numberOfColumns > 1 {
           assertionFailure("Pager && Horizontal items cannot exsist within a multi columned sections")
        }
        
        if let item = item as? HItem {
            return item.size
        } else if let item = item as? VItem {
            let width = collectionView.bounds.inset(by: collectionView.contentInset).inset(by: inset).width/CGFloat(numberOfColumns)
            let widthAdjustment: CGFloat = (numberOfColumns == 0) ? .zero : (0.18 + interitemSpacing)
            // Having this widthAdjustment allows us to have multi columns. Not sure why it works but needs investigation.
            
            return CGSize(width: width - widthAdjustment, height: item.estimatedHeight)
        } else {
            return .zero
        }
    }
    
    func sectionInset() -> UIEdgeInsets {
        return inset
    }
}

extension Section {
    
    // MARK: - Set size helper
    
    private func setSize(cell: UICollectionViewCell, indexPath: IndexPath, collectionView: UICollectionView){
        
        guard let item = items[safe: indexPath.row] else { return}
        
        let widthId = "cell.width"
        let heightId = "cell.height"
        
        NSLayoutConstraint.deactivate(cell.contentView.constraints.filter({ $0.identifier == widthId }))
        NSLayoutConstraint.deactivate(cell.contentView.constraints.filter({ $0.identifier == heightId }))
        
         if let _ = item as? VItem {
            
            if isGrid {
                // We want to match the height to the resizable width view due to device sizes
                cell.contentView.heightAnchor.constraint(equalToConstant: size(forRow: indexPath.row, collectionView: collectionView).width).with({
                    $0.priority = UILayoutPriority(999)
                    $0.isActive = true
                    $0.identifier = widthId
                })
            }
            
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
