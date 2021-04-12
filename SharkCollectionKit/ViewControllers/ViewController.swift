//
//  ViewController.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 04/04/2021.
//

import UIKit

class CoolLabel: UIView {
    
    let label = UILabel().with({
        $0.text = ""
        $0.backgroundColor = .white
    })
    
    init(text: String){
        super.init(frame: .zero)
        label.text = text
        VStack {
            label
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
}

final class ViewController: UIViewController {
    
    // MARK: - UI
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.autoSize())
    
    // MARK: -
    
    private lazy var collection = CollectionController(collectionView: collectionView)
    
    // MARK: - Init
    
    init(){
        super.init(nibName: nil, bundle: nil)
        setConstraints()
        collection.datasource = self
        collection.delegate = self
        view.backgroundColor = .blue
        collectionView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        collectionView.alwaysBounceVertical = true 

        HomeService.getHomeSections { sections in
            self.homeSections = sections
            self.collection.refresh()
            
        }
    }
    
    var homeSections: [Section] = []
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Configure
    
    private func setConstraints(){
        view.VStack {
            collectionView
        }
    }
    
    var testing = true

}

extension ViewController: CollectionDatasource {
    
    func sections() -> [Section] {
        homeSections
    }
}

extension ViewController: CollectionDelegate {
    
    func bindItem(_ item: Item) {
        
    }
    
    func didSelectItem(item: Item, indexPath: IndexPath) {
        print(indexPath)
    }
}
