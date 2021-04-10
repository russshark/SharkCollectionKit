//
//  SpaceItem.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 09/04/2021.
//

import UIKit

final private class VSpaceCell: UICollectionViewCell, VItem {
    
    var parentSection: Section?
    
    var estimatedHeight: CGFloat {
        return height
    }
    
    // MARK: - Init
    
    private let height: CGFloat
    
    init(height: CGFloat){
        self.height = height
        super.init(frame: .zero)
        contentView.backgroundColor = .clear
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}
