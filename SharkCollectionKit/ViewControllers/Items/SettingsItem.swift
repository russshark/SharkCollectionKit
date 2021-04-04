//
//  SettingsItem.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 04/04/2021.
//

import UIKit

final class SettingsItem: HItem {
    
    

    let text: String
    
    var didSelect: (() -> Void)?

    
    //MARK: - Init
    
    init(text: String){
        self.text = text
    }
    
    var binder: ItemCellBinderType {
        return ItemCellBinder<SettingsCell, SettingsItem>.init(item: self)
    }
    
    var parent: UICollectionView?
    
    var size: CGSize = .init(width: 340, height: 100)
}

final private class SettingsCell: UICollectionViewCell, BindableCell {
    
    //MARK: - UI
    
    private let label = UILabel()

    // MARK: -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
        styleView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Item

    var item: SettingsItem? {
        didSet {
            label.text = item?.text
        }
    }
    
    //MARK: - Configure
    
    private func styleView(){
        contentView.backgroundColor = .red
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        contentView.layer.masksToBounds = true
        label.textAlignment = .center
    }

    private func setConstraints(){
        contentView.vstack(label)
        
    }
}

