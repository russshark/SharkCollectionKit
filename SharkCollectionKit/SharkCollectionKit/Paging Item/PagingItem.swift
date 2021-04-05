//
//  PagingItem.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 04/04/2021.
//

import UIKit

final class PagingItem: NSObject, VItem {

    let items: [HItem]
    var spacing: CGFloat = .zero
    var inset: CGFloat = .zero
    var velocity: CGFloat = 1.5
    
    //MARK: - Init
    
    init(items: [HItem]){
        self.items = items
    }
    
    var parent: UICollectionView?
    
    var binder: ItemCellBinderType {
        return ItemCellBinder<PagingCell, PagingItem>.init(item: self)
    }

    var estimatedHeight: CGFloat {
        return items.compactMap({ $0.size.height }).max() ?? .zero
    }
    
    // MARK: - Chaining
    
    func setSpacing(_ spacing: CGFloat) -> Self {
        self.spacing = spacing
        return self
    }
    
    func setInset(_ inset: CGFloat) -> Self {
        self.inset = inset
        return self
    }
    
    func setVelocity(_ velocity: CGFloat) -> Self {
        self.velocity = velocity
        return self
    }
}

final private class PagingCell: UICollectionViewCell, BindableCell {
    
    //MARK: - UI
    
    lazy var layout = PagingCollectionViewLayout()
    
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
            guard let item = item, let parent = item.parent else {
                assertionFailure("Item has no parent UICollectionView assocaiated with it. We need this to set the item size")
                return
            }
            layout.sectionInset = UIEdgeInsets(top: .zero, left: item.inset, bottom: .zero, right: item.inset)
            layout.minimumLineSpacing = item.spacing
            layout.pageVelocity = item.velocity
            
            let adjustedWidth = parent.bounds.inset(by: parent.contentInset).width - (item.inset * 2.0)
            layout.itemSize = .init(width: adjustedWidth, height: item.estimatedHeight)
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
