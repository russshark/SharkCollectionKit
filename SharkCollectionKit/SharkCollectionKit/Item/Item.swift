//
//  Item.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 04/04/2021.
//

import UIKit

class BaseItem {}

protocol Item {
    var parentSection: Section? { get set }
    //var viewID: String { get set }
}

protocol VItem: Item {
    var estimatedHeight: CGFloat { get }
}

protocol HItem: Item {
    var size: CGSize { get }
}
