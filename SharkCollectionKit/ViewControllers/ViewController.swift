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
        vstack {
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
        collectionView.contentInset = .init(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Configure
    
    private func setConstraints(){
        view.vstack {
            collectionView
        }
    }
    
    var testing = true

}

extension ViewController: CollectionDatasource {
    
    func sections() -> [Section] {
        Section {
            HorizontalItem(spacing: 50) {
                SettingsItem(text: "Page 1")
                SettingsItem(text: "Page 1")
                SettingsItem(text: "Page 1")
                SettingsItem(text: "Page 1")
                SettingsItem(text: "Page 1")
                SettingsItem(text: "Page 1")
                SettingsItem(text: "Page 1")
                SettingsItem(text: "Page 1")
            }
            
            TestItem(text: "Some random text in here")
            TestItem(text: "--------Footer--------")
        }
        
        Section {
            TestItem(text: "New section")
            TestItem(text: "--------Header--------")
            TestItem(text: "Thsiu uhsih iuujndgj ffn jghdjn fgud nrjferj endj ffj nhdjfvd plfgfm fdm ng kfdkn d ngf i gfkd")
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
