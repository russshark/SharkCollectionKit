//
//  DataDrivenSectionFactory.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 11/04/2021.
//

import UIKit

class DataDrivenSectionFactory {
    static func makeSections(sectionModels: [SectionModel]) -> [Section]{
        var sections: [Section] = []

        sectionModels.forEach { sectionModel in
            let section = Section {
                makeItems(itemModels: sectionModel.items ?? [])
            }.inset(sectionModel.inset)
            .lineSpacing(sectionModel.spacing)

            sections.append(section)
        }
        
        return sections
    }
    
    static func makeItems(itemModels: [ItemModel]) -> [DataDrivenItem] {
        var items: [DataDrivenItem] = []
        
        itemModels.forEach { model in
            if let item = model.item {
                items.append(item)
            }
        }
        
        return items
    }
}
