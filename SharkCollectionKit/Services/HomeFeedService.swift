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



class HomeService {
    
    static func getHomeSections(completion: @escaping ([Section]) -> Void) {
        let sections = Bundle.main.decode(HomeFeed.self, from: "HomeFeedData.json")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            
            completion(DataDrivenSectionFactory.makeSections(sectionModels: sections.sections))
        })
    }

}
