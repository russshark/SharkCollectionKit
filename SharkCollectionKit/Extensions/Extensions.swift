//
//  Extensions.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 04/04/2021.
//

import UIKit

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension UICollectionViewFlowLayout {
    static func autoSize() -> UICollectionViewFlowLayout {
        let flow = UICollectionViewFlowLayout()
        flow.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return flow
    }
}

protocol Chainable {}

extension Chainable {
    
    @discardableResult
    func with(_ block: (Self) throws -> Void) rethrows -> Self {
        try block(self)
        return self
    }
}

extension NSObject: Chainable {}
