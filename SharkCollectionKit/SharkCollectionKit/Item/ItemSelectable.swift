//
//  ItemSelectable.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 10/04/2021.
//

import UIKit

class SelectableItem {}

extension SelectableItem {

    func didSelect(_ index: ((IndexPath) -> Void)?) -> Self {
        didSelect = index
        return self
    }
    
    private static var _didSelect: ((IndexPath) -> Void)? = nil
    
    var didSelect: ((IndexPath) -> Void)? {
        get {
            return SelectableItem._didSelect
        }
        set(newValue) {
            SelectableItem._didSelect = newValue
        }
    }
}
