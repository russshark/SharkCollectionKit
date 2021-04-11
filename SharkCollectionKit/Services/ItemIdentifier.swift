//
//  ItemIdentifier.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 10/04/2021.
//

import Foundation

enum ItemBuilder: String, Decodable {
    
    case baseTestItem = "BaseTestItem"
    case testItem2 = "TestItem2"
    case testHItem = "TestHItem"
    case gsPagerItem = "GSPagerItem"

    var metatype: DataDrivenItem.Type {
        switch self {
        case .baseTestItem:
            return BaseTestItem.self
        case .testItem2:
            return TestItem2.self
        case .testHItem:
            return TestHItem.self
        case .gsPagerItem:
            return GSPagerItem.self
        }
    }

}
