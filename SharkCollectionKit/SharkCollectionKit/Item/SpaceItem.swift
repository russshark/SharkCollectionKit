//
//  SpaceItem.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 09/04/2021.
//

import UIKit

final class VSpaceItem: VItem {

    let height: CGFloat
    
    static func maker(data: String) -> Item {
        return VSpaceItem(1)
    }
    
    //MARK: - Init
    
    init(_ height: CGFloat){
        self.height = height
    }
    
    var parentSection: Section?
    
    var binder: ItemCellBinderType {
        return ItemCellBinder<VSpaceCell, VSpaceItem>.init(item: self)
    }
    
    var estimatedHeight: CGFloat {
        return height
    }
}

final private class VSpaceCell: UICollectionViewCell, BindableCell {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Item

    var item: VSpaceItem? {
        didSet {
            heightAnchor.constraint(equalToConstant: item?.estimatedHeight ?? .zero).isActive = true
        }
    }
}
