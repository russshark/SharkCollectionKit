//
//  ViewController.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 04/04/2021.
//

import UIKit

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
        view.backgroundColor = .white
        collectionView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        collectionView.alwaysBounceVertical = true
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Configure
    
    private func setConstraints(){
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: .zero),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .zero),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: .zero),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .zero)
        ])
    }
}

extension ViewController: CollectionDatasource {
    
    func sections() -> [Section] {
        Section {
            PagingItem(items: [SettingsItem(text: "1"), SettingsItem(text: "2"), SettingsItem(text: "3")])
            TestItem(text: "This is a test  fb his is a test  fb bbd fbb")
            TestItem(text: "This is a test  fb his is a test  fb bbd fbb")
            
            
            TestItem(text: "This is a test  fb his is a test  fb bbd fbb")
            
            [TestItem(text: "This is a test  fb his is a test  fb bbd fbb"), TestItem(text: "This is a test  fb his is a test  fb bbd fbb")]
            
            
            if view.backgroundColor == .white {
                TestItem(text: "This is a test  fb his is a test  fb bbd fbb🍕")
            } else {
                TestItem(text: "This is a test  fb his is a test  fb bbd fbb")
                TestItem(text: "This is a test  fb his is a test  fb bbd fbb")
                TestItem(text: "This is a test  fb his is a test  fb bbd fbb")
            }
        }
        
        Section {
            TestItem(text: "🚀This is a test  fb his is a test  fb bbd fbb")
            TestItem(text: "This is a test  fb his is a test  fb bbd fbb")
            
            
            TestItem(text: "This is a test  fb his is a test  fb bbd fbb")
            
            [TestItem(text: "This is a test  fb his is a test  fb bbd fbb"), TestItem(text: "This is a test  fb his is a test  fb bbd fbb")]
            
            
            if view.backgroundColor == .white {
                TestItem(text: "This is a test  fb his is a test  fb bbd fbb")
            } else {
                TestItem(text: "This is a test  fb his is a test  fb bbd fbb")
                TestItem(text: "This is a test  fb his is a test  fb bbd fbb")
                TestItem(text: "This is a test  fb his is a test  fb bbd fbb")
            }
        }
    }
}

extension ViewController: CollectionDelegate {
    
    func bindItem(_ item: Item) {
        if let item = item as? TestItem {
            item.didSelect = {
                print(item)
            }
        }
    }
    
    func didSelectItem(item: Item, indexPath: IndexPath) {
        print(indexPath)
    }
}
