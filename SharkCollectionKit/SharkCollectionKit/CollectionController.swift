//
//  ListController.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 04/04/2021.
//
import UIKit

protocol CollectionDelegate: AnyObject {
    func bindItem(_ item: Item)
    func didSelectItem(item: Item, indexPath: IndexPath)
}

protocol CollectionDatasource: AnyObject {
    @GenericArrayBuilder<Section> func sections() -> [Section]
}

final class CollectionController: NSObject {
    
    // MARK: - Delegate
    
    weak var datasource: CollectionDatasource?
    weak var delegate: CollectionDelegate?
    
    var horizontalFlowLayout: UICollectionViewFlowLayout? = nil
    
    // MARK: - Dependencies
    
    private let collectionView: UICollectionView
        
    // MARK: - Init
    
    init(collectionView: UICollectionView){
        self.collectionView = collectionView
        super.init()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    // MARK: -
    
    func refresh(){
        collectionView.reloadData()
    }

    // MARK: - Private
    
    private var sections: [Section] {
        return datasource?.sections() ?? []
    }
}

extension CollectionController: UICollectionViewDataSource {
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[safe: section]?.numberOfItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let section = sections[safe: indexPath.section],
              let (item, cell) = section.cellFor(forIndexPath: indexPath, collectionView: collectionView) else {
            assertionFailure("We should always return a cell and item")
            return UICollectionViewCell()
        }
        
        delegate?.bindItem(item)

        return cell
    }
}

extension CollectionController: UICollectionViewDelegate {
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = sections[safe: indexPath.section]?.items[safe: indexPath.row] else { return }
        
        delegate?.didSelectItem(item: item, indexPath: indexPath)
        
        if let item = item as? SelectableItem {
            item.didSelect?(indexPath)
        }
    }
}

extension CollectionController: UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sections[safe: indexPath.section]?.size(forRow: indexPath.row, collectionView: collectionView) ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sections[safe: section]?.columnSpacing() ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if let horizontalLayout = horizontalFlowLayout { return horizontalLayout.minimumLineSpacing }
        return sections[safe: section]?.lineSpacing() ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if let horizontalLayout = horizontalFlowLayout { return horizontalLayout.sectionInset }
        return sections[safe: section]?.sectionInset() ?? .zero
    }
}
