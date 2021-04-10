//
//  ItemIdentifier.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 10/04/2021.
//

import Foundation

enum ItemBuilder: String, Decodable {
    
    case testItem = "TestItem"

    var metatype: DataDrivenItem.Type {
        switch self {
        case .testItem:
            return TestItem.self
        }
    }

}
