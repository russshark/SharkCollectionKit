//
//  ProfilePictureItem.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 12/04/2021.
//

import UIKit

final class ProfilePictureItem: SelectableItem, HItem, DataDrivenConfigurable {

    // MARK: -
    
    var viewModel: TestViewModel?
    
    // MARK: - Init
    
    required init(from decoder: Decoder) throws {
        let data: TestModel = try .init(from: decoder)
        viewModel = TestViewModel(model: data)
    }
    
    // MARK: - VItem
    
    var parentSection: Section?
    
    var size: CGSize = .init(width: 60, height: 60)

    var binder: ItemCellBinderType {
        return ItemCellBinder<ProfilePictureCell, ProfilePictureItem>.init(item: self)
    }
}

final private class ProfilePictureCell: UICollectionViewCell, BindableCell {
    
    //MARK: - UI
    
    private let label = UILabel().with({
        $0.numberOfLines = 0
        $0.textAlignment = .center
    })

    // MARK: -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        styleView()
        
        contentView.HStack {
            label
        }.withHeight(100)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Itemyou

    var item: ProfilePictureItem? {
        didSet {
            label.text = item?.viewModel?.title
        }
    }
    
    //MARK: - Configure
    
    private func styleView(){
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        contentView.layer.masksToBounds = true
    }

}