//
//  PagerCollectionViewLayout.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 04/04/2021.
//

import UIKit

final class PagerCollectionViewLayout: UICollectionViewFlowLayout {
    
    
    private var numberOfItemsPerPage: CGFloat = 1
    var minVelocity: CGFloat = 1.5

    // MARK: - Init
        
    override init() {
        super.init()
        scrollDirection = .horizontal
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: -
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return proposedContentOffset }
        
        let pageLength: CGFloat
        let approxPage: CGFloat
        let currentPage: CGFloat
        let speed: CGFloat
        
        pageLength = (itemSize.width + minimumLineSpacing) * numberOfItemsPerPage
        approxPage = collectionView.contentOffset.x / pageLength
        speed = velocity.x

        if speed < 0 {
            currentPage = ceil(approxPage)
        } else if speed > 0 {
            currentPage = floor(approxPage)
        } else {
            currentPage = round(approxPage)
        }
        
        guard speed != 0 else {
            return CGPoint(x: currentPage * pageLength, y: 0)
        }
        
        var nextPage: CGFloat = currentPage + (speed > 0 ? 1 : -1)
        
        let increment = speed / minVelocity
        nextPage += (speed < 0) ? ceil(increment) : floor(increment)
        
        return CGPoint(x: nextPage * pageLength, y: 0)
    }
}
