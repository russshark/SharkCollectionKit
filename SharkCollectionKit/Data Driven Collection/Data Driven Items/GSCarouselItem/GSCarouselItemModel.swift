//
//  GSCarouselItemModel.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 12/04/2021.
//

import CoreGraphics

struct GSCarouselItemModel: Decodable {
    let items: [ItemModel]
    let spacing: CGFloat
    let horizontalInset: CGFloat
    
    // MARK: -
    
    private enum CodingKeys: String, CodingKey {
        case items
        case spacing
        case horizontalInset = "horizontal-inset"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.items = try container.decode([ItemModel].self, forKey: .items).compactMap({ $0 })
        self.spacing = (try? container.decode(CGFloat.self, forKey: .spacing)) ?? .zero
        self.horizontalInset = (try? container.decode(CGFloat.self, forKey: .horizontalInset)) ?? .zero
    }
}
