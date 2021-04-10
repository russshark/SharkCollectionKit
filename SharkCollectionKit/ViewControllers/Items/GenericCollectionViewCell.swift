//
//  GenericCollectionViewCell.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 10/04/2021.
//

import UIKit


final class GenericCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UI
    
    var testView: UIView? {
        didSet {
            VStack {
                testView
            }
        }
    }
    
//    convenience init(<#parameters#>) {
//        <#statements#>
//    }
//    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Item
}


//class GenericTableCell<InnerView: UIView>: HiddableTableCell, ReusableCell {
//    let innerContentView = InnerView() // Don't kill this init basic
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        backgroundColor = .clear
//        selectionStyle = .none
//        contentView.backgroundColor = .clear
//        contentView.withEdgePinnedContent {[
//            innerContentView
//        ]}
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
