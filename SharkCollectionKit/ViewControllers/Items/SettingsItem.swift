//
//  SettingsItem.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 04/04/2021.
//

import UIKit

final class SettingsItem: NSObject, HItem {

    let text: String

    //MARK: - Init
    
    init(text: String){
        self.text = text
    }
    
    var binder: ItemCellBinderType {
        return ItemCellBinder<SettingsCell, SettingsItem>.init(item: self)
    }
    
    var parentSection: Section?
    
    var size: CGSize = .init(width: 100, height: 100)
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
        contentView.VStack {
            label
        }
        
    }
}

