//
//  HorizontalItem.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 06/04/2021.
//

import UIKit

final class HorizontalCell: UICollectionViewCell, VItem {
    
    let items: [HItem]
    var spacing: CGFloat = .zero
    var inset: CGFloat = .zero
    var velocity: CGFloat = 1.5
    
    //MARK: - Init
    
    init(spacing: CGFloat = .zero, @GenericArrayBuilder<HItem> items: () -> [HItem]){
        self.spacing = spacing
        self.items = items()
        super.init(frame: .zero)
        contentView.backgroundColor = .clear
        contentView.VStack {
            collectionView
        }
        collection.datasource = self
        layout.sectionInset = UIEdgeInsets(top: .zero, left: inset, bottom: .zero, right: inset)
        layout.minimumLineSpacing = spacing
        collection.horizontalFlowLayout = layout
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
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
    
    //MARK: - UI
        
    private lazy var collection = CollectionController(collectionView: collectionView)
    
    private let layout = UICollectionViewFlowLayout().with {
        $0.scrollDirection = .horizontal
    }
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        return collectionView
    }()
    
}
 
extension HorizontalCell: CollectionDatasource {
    func sections() -> [Section] {
        Section {
            items
        }
    }
}
