//
//  PagingItem.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 04/04/2021.
//

import UIKit

final class PagingItem: VItem {

    let items: [HItem]
    let parent: UICollectionView
    
    var didSelect: (() -> Void)?

    
    //MARK: - Init
    
    init(items: [HItem], parent: UICollectionView){
        self.items = items
        self.parent = parent
    }
    
    var binder: ItemCellBinderType {
        return ItemCellBinder<PagingCell, PagingItem>.init(item: self)
    }
    
    var estimatedHeight: CGFloat {
        // This gets the max height from all the cells we want to display
        return items.compactMap({ $0.size.height }).max() ?? .zero
    }
}

final private class PagingCell: UICollectionViewCell, BindableCell {
    
    //MARK: - UI
    
    lazy var collectionView: UICollectionView = {
        let layout = PagingCollectionViewLayout(spacing: 30, inset: 0, size: .init(width: 340, height: 100))
        
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

    var item: PagingItem?
    
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
