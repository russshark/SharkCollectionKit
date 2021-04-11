//
//  TestCell2.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 11/04/2021.
//

import UIKit

final class TestCell2: UICollectionViewCell, BindableCell {
    
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

    var item: TestItem2? {
        didSet {
            label.text = item?.viewModel?.title
        }
    }
    
    //MARK: - Configure
    
    private func styleView(){
        contentView.backgroundColor = .red
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        contentView.layer.masksToBounds = true
    }

}
