//
//  Item.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 04/04/2021.
//

import UIKit

protocol Item {
    var binder: ItemCellBinderType { get }
    var parent: UICollectionView? { get set }
}

protocol VItem: Item {
    var estimatedHeight: CGFloat { get }
}

protocol HItem: Item {
    var size: CGSize { get }
}
