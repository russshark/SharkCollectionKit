//
//  InsetModel.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 12/04/2021.
//

import UIKit

struct InsetDecodable: Decodable {
    private let left: CGFloat
    private let top: CGFloat
    private let right: CGFloat
    private let bottom: CGFloat
    
    private enum CodingKeys: String, CodingKey {
        case left = "left-inset"
        case top = "top-inset"
        case right = "right-inset"
        case bottom = "bottom-inset"
    }
    
    // MARK: - Init
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.left = (try? container.decode(CGFloat.self, forKey: .left)) ?? .zero
        self.top = (try? container.decode(CGFloat.self, forKey: .top)) ?? .zero
        self.right = (try? container.decode(CGFloat.self, forKey: .right)) ?? .zero
        self.bottom = (try? container.decode(CGFloat.self, forKey: .bottom)) ?? .zero
    }
    
    var edgeInset: UIEdgeInsets {
        return .init(top: top, left: left, bottom: bottom, right: right)
    }
}
