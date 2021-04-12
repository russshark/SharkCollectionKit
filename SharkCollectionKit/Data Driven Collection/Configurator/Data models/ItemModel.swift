//
//  ItemModel.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 12/04/2021.
//

import Foundation

final class ItemModel: Decodable {

    let item: DataDrivenItem?
    
    // MARK: -
    
    private enum CodingKeys: CodingKey {
        case id
    }
    
    // MARK: -

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(DataDrivenItemConfig.self, forKey: .id)
        
        self.item = try type.dataItem.init(from: decoder)
    }
}
