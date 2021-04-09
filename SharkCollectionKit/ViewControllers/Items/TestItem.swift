//
//  TestItem.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 04/04/2021.
//

import UIKit

final class TestItem: NSObject, VItem {

    let text: String
    
    var didSelect: (() -> Void)?

    
    //MARK: - Init
    
    init(text: String){
        self.text = text
    }
    
    var binder: ItemCellBinderType {
        return ItemCellBinder<TestCell, TestItem>.init(item: self)
    }
    
    var parent: UICollectionView?
    
    var estimatedHeight: CGFloat = 50.0
}

final private class TestCell: UICollectionViewCell, BindableCell {
    
    //MARK: - UI
    
    private let label = UILabel()
    private let button = UIButton().with {
        $0.setTitle("Test button", for: .normal)
    }
    // MARK: -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
        styleView()
        button.addTarget(self, action: #selector(handleRegister(sender:)), for: .touchUpInside)

    }
    
    @objc func handleRegister(sender: UIButton){
        item?.didSelect?()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Item

    var item: TestItem? {
        didSet {
            label.text = item?.text
        }
    }
    
    //MARK: - Configure
    
    private func styleView(){
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        contentView.layer.masksToBounds = true
        label.numberOfLines = 0
        label.textAlignment = .center
    }

    private func setConstraints(){
        contentView.HStack {
            label
        }.withHeight(100, priority: UILayoutPriority(500))
        
    }
}
