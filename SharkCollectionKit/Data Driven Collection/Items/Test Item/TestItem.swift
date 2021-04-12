//
//  TestItem.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 11/04/2021.
//

import UIKit

struct TestViewModel {
    
    // MARK: -
    
    private let model: TestModel
    
    // MARK: - Init
    
    init(model: TestModel){
        self.model = model
    }
    
    // MARK: - Properties
    
    var title: String {
        return model.title.uppercased()
    }
    
}

class BaseTestItem: SelectableItem, VItem, DataDrivenConfigurable {
    
    // MARK: -
    
    var viewModel: TestViewModel?
    
    // MARK: - Init
    
    required init(from decoder: Decoder) throws {
        let data: TestModel = try .init(from: decoder)
        viewModel = TestViewModel(model: data)
    }
    
    // MARK: - VItem
    
    var parentSection: Section?
    
    var estimatedHeight: CGFloat = 50.0

    var binder: ItemCellBinderType {
        return ItemCellBinder<TestCell, BaseTestItem>.init(item: self)
    }
}


final class TestItem2: BaseTestItem {
    override var binder: ItemCellBinderType {
        return ItemCellBinder<TestCell2, TestItem2>.init(item: self)
    }
}
