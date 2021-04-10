//
//  ItemSelectable.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 10/04/2021.
//

import UIKit

protocol ItemSelectable {}

extension BaseItem: ItemSelectable {

    func didSelect(_ index: ((IndexPath) -> Void)?) -> Self {
        didSelect = index
        return self
    }
    
    private static var _didSelect: ((IndexPath) -> Void)? = nil
    
    var didSelect: ((IndexPath) -> Void)? {
        get {
            return BaseItem._didSelect
        }
        set(newValue) {
            BaseItem._didSelect = newValue
        }
    }
}
