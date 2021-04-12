//
//  ItemIdentifier.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 10/04/2021.
//

import Foundation

// This is where we map incoming item types to there class

protocol DataDrivenConfigurable: Decodable {}

typealias DataDrivenItem = (DataDrivenConfigurable & Item)

enum DataDrivenItemConfig: String, Decodable {
    
    case carousel = "carousel"
    case pager = "pager"
    
    case baseTestItem = "BaseTestItem"
    case testItem2 = "TestItem2"
    case testHItem = "TestHItem"
    case profilePicture = "ProfilePictureItem"

    var dataItem: DataDrivenItem.Type {
        switch self {
        case .pager:
            return GSPagerItem.self
        case .carousel:
            return GSCarouselItem.self
        
        case .baseTestItem:
            return BaseTestItem.self
        case .testItem2:
            return TestItem2.self
        case .testHItem:
            return TestHItem.self
        case .profilePicture:
            return ProfilePictureItem.self
        }
    }

}
