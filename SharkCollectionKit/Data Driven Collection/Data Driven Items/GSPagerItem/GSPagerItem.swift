//
//  PagingItem.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 11/04/2021.
//

import UIKit

final class GSPagerItem: PagerItem, DataDrivenConfigurable {
    
    //MARK: - Init
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let data: GSPagerItemModel = try .init(from: decoder)
        
        self.items = DataDrivenSectionFactory.makeItems(itemModels: data.items) as? [HItem] ?? []
        self.spacing = data.spacing
        self.inset(data.horizontalInset)
    }
    
    override var binder: ItemCellBinderType {
        return ItemCellBinder<GSPagerCell, GSPagerItem>.init(item: self)
    }
}

final class GSPagerCell: UICollectionViewCell, BindableCell {
    
    //MARK: - UI
    
    private let layout = PagerCollectionViewLayout()
    
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
    
    //MARK: - Item

    var item: GSPagerItem? {
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

extension GSPagerCell: UICollectionViewDataSource {
    
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
