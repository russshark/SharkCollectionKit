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
        view.backgroundColor = .blue
        collectionView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = .init(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Configure
    
    private func setConstraints(){
        view.vstack(spacing: 10, safeArea: true) {
            collectionView
            UILabel().with({
                $0.text = "this is atest"
                $0.backgroundColor = .white
            })
            
            view.zstack {
                UILabel().with({
                    $0.text = "7"
                    $0.backgroundColor = .clear
                })
                UILabel().with({
                    $0.text = "8"
                    $0.backgroundColor = .clear
                })
            }
        }
    }
    
    var testing = false
}

extension ViewController: CollectionDatasource {
    
    func sections() -> [Section] {
        Section {
            PagingItem(items: [SettingsItem(text: "Page 1"), SettingsItem(text: "Page 2"), SettingsItem(text: "Page 3")])
            .setSpacing(100)
            .setInset(30)
            .setVelocity(2.5)
            
            TestItem(text: "Russell Warwick")
            
            if testing{
                TestItem(text: "This is test data! 🤖")
                TestItem(text: "This is all test data for the purpose of testing things out")
            } else {
                TestItem(text: "This is some live data")
                TestItem(text: "Live information here")
                TestItem(text: "🚀🚀🚀🚀🚀🚀🚀🚀🚀")
            }
            
            TestItem(text: " ")
        }
  
        if testing {
            Section {
                TestItem(text: "This section will only appear when in test mode")
                TestItem(text: "How great is this")
                
                PagingItem(items: [SettingsItem(text: "Page 1"), SettingsItem(text: "Page 2"), SettingsItem(text: "Page 3")])
                .setSpacing(100)
                .setInset(30)
                .setVelocity(2.5)
                
                TestItem(text: "End of test section")
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
        testing.toggle()
        collectionView.reloadData()
    }
}
