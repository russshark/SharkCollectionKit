//
//  PagingItem.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 04/04/2021.
//

import UIKit

final class PagingCell: UICollectionViewCell, VItem {
    
    //MARK: - Properties

    let items: [HItem]
    var spacing: CGFloat = .zero
    var inset: CGFloat = .zero
    var minVelocity: CGFloat = 2.4
    var sectionInset: UIEdgeInsets = .zero
    
    //MARK: - Init
    
    init(@GenericArrayBuilder<HItem> items: () -> [HItem]){
        self.items = items()
        super.init(frame: .zero)
        
        contentView.backgroundColor = .clear
        contentView.VStack {
            collectionView
        }
        guard let parentSection = parentSection, let collectionView = parentSection.collectionView else {
            assertionFailure("Item has no parent UICollectionView assocaiated with it. We need this to set the item size")
            return
        }
        
        layout.sectionInset = UIEdgeInsets(top: .zero, left: inset, bottom: .zero, right: inset)
        layout.minimumLineSpacing = spacing
        layout.minVelocity = minVelocity
        
        let adjustedWidth = collectionView.bounds.inset(by: collectionView.contentInset).inset(by: parentSection.sectionInset()).width - (inset * 2.0)
        layout.itemSize = .init(width: adjustedWidth, height: estimatedHeight)
    }
    
    //MARK: - VItem
    
    var parentSection: Section?

    var estimatedHeight: CGFloat {
        return items.compactMap({ $0.size.height }).max() ?? .zero
    }
    
    // MARK: - Chaining
    
    @discardableResult
    func spacing(_ spacing: CGFloat) -> Self {
        self.spacing = spacing
        return self
    }
    
    @discardableResult
    func inset(_ inset: CGFloat) -> Self {
        self.inset = inset
        return self
    }
    
    @discardableResult
    func minVelocity(_ velocity: CGFloat) -> Self {
        self.minVelocity = velocity
        return self
    }
    
    //MARK: - UI
    
    private lazy var layout = PagerCollectionViewLayout()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK: -
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}

extension PagingCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let item = items[safe: indexPath.row] as? UICollectionViewCell {
            return item
        }
        
        return UICollectionViewCell()
    }
}
