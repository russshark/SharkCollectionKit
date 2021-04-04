//
//  Item.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 04/04/2021.
//

import CoreGraphics

protocol Item {
    var binder: ItemCellBinderType { get }
}

protocol VItem: Item {
    var estimatedHeight: CGFloat { get }
}

protocol HItem: Item {
    var size: CGSize { get }
}
