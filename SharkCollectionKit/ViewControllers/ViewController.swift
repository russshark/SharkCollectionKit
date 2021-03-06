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
        view.backgroundColor = .blue
        collectionView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = .init(top: 40, left: 20, bottom: 0, right: 20)
    }
    
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
        
        Section {
            TestItem(text: "Some random text in here")
        }
        
        Section {

            (0..<6).map { (id: Int) in
                TestItem(text: "Test: \(id)").didSelect { item in
                    print(item)
                }
            }
        }.lineSpacing(10)
        .columnSpacing(10)
        .columns(3)
        .isGrid(true)
        .inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        
        Section {
            TestItem(text: "Some random text in here")
        }
    }
}
