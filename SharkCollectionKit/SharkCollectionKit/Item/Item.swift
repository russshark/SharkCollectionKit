//
//  Item.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 04/04/2021.
//

import UIKit

protocol ItemData: Decodable {
    
}

protocol Item {
    var binder: ItemCellBinderType { get }
    var parentSection: Section? { get set }
}

protocol DataDrivenItem: Item, Decodable{
}

protocol VItem: Item {
    var estimatedHeight: CGFloat { get }
}

protocol HItem: Item {
    var size: CGSize { get }
}
