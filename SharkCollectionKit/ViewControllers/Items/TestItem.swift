//
//  TestItem.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 04/04/2021.
//

import UIKit

struct TestData: Decodable {
    
    let title: String
}

class TestItem: SelectableItem, VItem, DataDrivenItem {

    let text: String = "rr"
    
    var someViewAction: (() -> Void)?
    func someViewAction(_ action: (() -> Void)?) -> Self {
        someViewAction = action
        return self
    }
    
    private enum CodingKeys: CodingKey {
        case data
    }
    
    let testData: TestData?
    
    required init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let test = try container.decode(TestData.self, forKey: .data)
            self.testData = test
            
        } catch {
            self.testData = nil
        }
    }
    
    //MARK: - Init

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
    
    //MARK: - Itemyou

    var item: TestItem? {
        didSet {
            label.text = item?.testData?.title
            item?.someViewAction?()
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
