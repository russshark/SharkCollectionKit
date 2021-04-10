//
//  GenericCollectionViewCell.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 10/04/2021.
//

import UIKit


final class GenericCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UI
    
    public private(set) var view: UIView?
    
    weak var testView: UIView? {
        didSet {
            guard self.view == nil else {
              return
            }

            self.view = testView
            guard let testView = testView else { return }
            testView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(testView)
            NSLayoutConstraint.activate([
                testView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                testView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                testView.topAnchor.constraint(equalTo: contentView.topAnchor),
                testView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            ])
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        print("refetcg")
    }
    

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
