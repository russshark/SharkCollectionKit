//
//  ItemCellBinder.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 04/04/2021.
//

import UIKit

protocol BindableCell {
    associatedtype DataType
    var item: DataType? { get set }
}

protocol ItemCellBinderType {
    func configure(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell?
}

final class ItemCellBinder<CellType: BindableCell, DataType>: ItemCellBinderType where CellType.DataType == DataType, CellType: UICollectionViewCell {
    
    // MARK: - Dependencies
    
    private let item: DataType
    
    // MARK: - Init
    
    init(item: DataType) {
        self.item = item
    }

    func configure(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell? {
        
        let cellId = String(describing: CellType.self)
    
        collectionView.register(CellType.self, forCellWithReuseIdentifier: cellId)
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? CellType
        
        cell?.item = item //Setting the BindableCell item

        return cell
    }
}
