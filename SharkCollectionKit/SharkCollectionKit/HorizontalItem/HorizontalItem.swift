//
//  HorizontalItem.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 06/04/2021.
//

import UIKit

final class HorizontalItem: NSObject, VItem {

    let items: [HItem]
    var spacing: CGFloat = .zero
    var inset: CGFloat = .zero
    var velocity: CGFloat = 1.5

    //MARK: - Init
    
    init(spacing: CGFloat = .zero, @GenericArrayBuilder<HItem> items: () -> [HItem]){
        self.spacing = spacing
        self.items = items()
    }
    
    var parentSection: Section?
    
    var binder: ItemCellBinderType {
        return ItemCellBinder<HorizontalCell, HorizontalItem>.init(item: self)
    }

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
}

final private class HorizontalCell: UICollectionViewCell, BindableCell {
    
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
    
    // MARK: -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        contentView.VStack {
            collectionView
        }
        collection.datasource = self
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Item

    var item: HorizontalItem? {
        didSet {
            guard let item = item else { return }
            layout.sectionInset = UIEdgeInsets(top: .zero, left: item.inset, bottom: .zero, right: item.inset)
            layout.minimumLineSpacing = item.spacing
            collection.horizontalFlowLayout = layout
        }
    }
}
 
extension HorizontalCell: CollectionDatasource {
    func sections() -> [Section] {
        Section {
            item?.items ?? []
        }
    }
}
