//
//  PagingItem.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 04/04/2021.
//

import UIKit

class PagerItem: VItem, ItemParent {
    
    // MARK: - Properties

    var items: [HItem]
    var spacing: CGFloat = .zero
    var inset: CGFloat = .zero
    var minVelocity: CGFloat = 2.4
    var sectionInset: UIEdgeInsets = .zero
    
    // MARK: - Init
    
    init(){
        self.items = []
    }

    init(@GenericArrayBuilder<HItem> items: () -> [HItem]){
        self.items = items()
    }
    
    // MARK: - VItem
    
    var parentSection: Section?
    
    var binder: ItemCellBinderType {
        return ItemCellBinder<PagerCell, PagerItem>.init(item: self)
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
    
    @discardableResult
    func minVelocity(_ velocity: CGFloat) -> Self {
        self.minVelocity = velocity
        return self
    }
}

final private class PagerCell: UICollectionViewCell, BindableCell {
    
    // MARK: - UI
    
    private lazy var layout = PagerCollectionViewLayout()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).with {
        $0.showsHorizontalScrollIndicator = false
        $0.decelerationRate = .fast
        $0.dataSource = self
        $0.backgroundColor = .clear
    }
    
    // MARK: -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.VStack {
            collectionView
        }
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Item

    var item: PagerItem? {
        didSet {
            guard let item = item, let parentSection = item.parentSection, let collectionView = parentSection.collectionView else {
                assertionFailure("Item has no parent UICollectionView assocaiated with it. We need this to set the item size")
                return
            }
            
            layout.sectionInset = UIEdgeInsets(top: .zero, left: item.inset, bottom: .zero, right: item.inset)
            layout.minimumLineSpacing = item.spacing
            layout.minVelocity = item.minVelocity
            
            let adjustedWidth = collectionView.bounds.inset(by: collectionView.contentInset).inset(by: parentSection.sectionInset()).width - (item.inset * 2.0)
            layout.itemSize = .init(width: adjustedWidth, height: item.estimatedHeight)
        }
    }
}

extension PagerCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let item = item?.items[safe: indexPath.row], let cell = item.binder.configure(for: collectionView, indexPath: indexPath) {
            return cell
        }
        
        return UICollectionViewCell()
    }
}
