//
//  ItemSelectable.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 10/04/2021.
//

import UIKit

protocol ItemSelectable {}

class Selectable {}

extension Selectable: ItemSelectable {

    func didSelect(_ index: ((IndexPath) -> Void)?) -> Self {
        didSelect = index
        return self
    }
    
    private static var _didSelect: ((IndexPath) -> Void)? = nil
    
    var didSelect: ((IndexPath) -> Void)? {
        get {
            return Selectable._didSelect
        }
        set(newValue) {
            Selectable._didSelect = newValue
        }
    }
}
