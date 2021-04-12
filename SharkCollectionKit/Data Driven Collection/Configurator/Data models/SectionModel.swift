//
//  SectionModel.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 11/04/2021.
//

import UIKit

struct SectionModel: Decodable {
    let items: [ItemModel]?
    let spacing: CGFloat
    let inset: UIEdgeInsets
    
    
    // MARK: -
    
    private enum CodingKeys: String, CodingKey {
        case items
        case spacing
        
        case leftInset = "left-inset"
        case topInset = "top-inset"
        case rightInset = "right-inset"
        case bottomInset = "bottom-inset"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.items = try container.decode([ItemModel].self, forKey: .items).compactMap({ $0 })
        self.spacing = (try? container.decode(CGFloat.self, forKey: .spacing)) ?? .zero
        self.inset = try InsetDecodable(from: decoder).edgeInset
    }
}


