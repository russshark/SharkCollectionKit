//
//  TestItem.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 04/04/2021.
//

import UIKit

final class TestItem: BaseItem, VItem {

    let text: String
    
    var _lol: (() -> Void)?
    func lol(_ v: (() -> Void)?) -> Self {
        _lol = v
        return self
    }

    //MARK: - Init
    
    init(text: String){
        self.text = text
    }
    
    var binder: ItemCellBinderType {
        return ItemCellBinder<TestCell, TestItem>.init(item: self)
    }
    
    var parentSection: Section?
    
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
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Item

    var item: TestItem? {
        didSet {
            label.text = item?.text
            item?._lol?()
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
