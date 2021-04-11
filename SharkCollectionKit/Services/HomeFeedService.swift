//
//  HomeFeedService.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 10/04/2021.
//

import Foundation

struct HomeFeed: Decodable {
    let sections: [SectionModel]
}

class SectionModel: Decodable {
    let items: [AnyItemModel]?
    
    
    private enum CodingKeys: CodingKey {
        case items
    }
    
    required init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.items = try container.decode([AnyItemModel].self, forKey: .items).compactMap({ $0 })
        } catch {
            self.items = nil
        }
    }
}

class AnyItemModel: Decodable {
    
    
    private enum CodingKeys: CodingKey {
        case id
    }

    let item: DataDrivenItem?

    required init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(ItemBuilder.self, forKey: .id)
            
            self.item = try type.metatype.init(from: decoder)
        } catch {
            self.item = nil
        }
    }
}


class HomeService {
    
    static func getHomeSections(completion: @escaping ([Section]) -> Void) {
        let sections = Bundle.main.decode(HomeFeed.self, from: "HomeFeedData.json")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            
            completion(self.makeSections(sectionModels: sections.sections))
        })
    }

    static func makeSections(sectionModels: [SectionModel]) -> [Section]{
        var sections: [Section] = []

        sectionModels.forEach { sectionModel in
            sections.append(Section {
                makeItems(itemModels: sectionModel.items ?? [])
            })
        }
        
        return sections
    }
    
    static func makeItems(itemModels: [AnyItemModel]) -> [DataDrivenItem] {
        var items: [DataDrivenItem] = []
        
        itemModels.forEach { model in
            if let item = model.item {
                items.append(item)
            }
        }
        
        return items
    }

    
}
