//
//  PagingItem.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 04/04/2021.
//

import UIKit

final class PagingItem: VItem {

    let items: [HItem]
    
    var didSelect: (() -> Void)?

    
    //MARK: - Init
    
    init(items: [HItem]){
        self.items = items
    }
    
    var binder: ItemCellBinderType {
        return ItemCellBinder<PagingCell, PagingItem>.init(item: self)
    }
    
    var parent: UICollectionView?
    
    var estimatedHeight: CGFloat {
        // This gets the max height from all the cells we want to display
        return items.compactMap({ $0.size.height }).max() ?? .zero
    }
}

final private class PagingCell: UICollectionViewCell, BindableCell {
    
    //MARK: - UI
    
    lazy var layout = PagingCollectionViewLayout(spacing: 30, inset: 0)
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK: -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
        styleView()

    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Item

    var item: PagingItem? {
        didSet {
            guard let parent = item?.parent, let height = item?.estimatedHeight else {
                assertionFailure("Item has no parent UICollectionView assocaiated with it. We need this to set the item size")
                return
            }
            
            layout.itemSize = .init(width: parent.bounds.inset(by: parent.contentInset).width, height: height)
        }
    }
    
    //MARK: - Configure
    
    private func styleView(){
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        contentView.layer.masksToBounds = true
    }

    private func setConstraints(){
        contentView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .zero),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: .zero),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: .zero),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .zero)
        ])
    }
}

extension PagingCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = item?.items[safe: indexPath.row],
              let cell = item.binder.configure(for: collectionView, indexPath: indexPath) else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}
