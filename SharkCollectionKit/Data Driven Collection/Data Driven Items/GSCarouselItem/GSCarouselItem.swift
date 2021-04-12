//
//  GSCarouselItem2.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 12/04/2021.
//

import UIKit

final class GSCarouselItem: CarouselItem, DataDrivenConfigurable {

    // MARK: - Init
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let data: GSCarouselItemModel = try .init(from: decoder)
        
        self.items = DataDrivenSectionFactory.makeItems(itemModels: data.items) as? [HItem] ?? []
        self.spacing = data.spacing
        self.inset = data.horizontalInset
    }

    override var binder: ItemCellBinderType {
        return ItemCellBinder<GSCarouselCell, GSCarouselItem>.init(item: self)
    }
}

final private class GSCarouselCell: UICollectionViewCell, BindableCell {
    
    // MARK: - UI
        
    private lazy var collection = CollectionController(collectionView: collectionView)
    
    private let layout = UICollectionViewFlowLayout().with {
        $0.scrollDirection = .horizontal
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).with {
        $0.showsHorizontalScrollIndicator = false
        $0.alwaysBounceHorizontal = true
        $0.backgroundColor = .clear
    }
    
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
    
    // MARK: - Item

    var item: GSCarouselItem? {
        didSet {
            guard let item = item else { return }
            layout.sectionInset = UIEdgeInsets(top: .zero, left: item.inset, bottom: .zero, right: item.inset)
            layout.minimumLineSpacing = item.spacing
            collection.horizontalFlowLayout = layout
        }
    }
}
 
extension GSCarouselCell: CollectionDatasource {
    func sections() -> [Section] {
        Section {
            item?.items ?? []
        }
    }
}
