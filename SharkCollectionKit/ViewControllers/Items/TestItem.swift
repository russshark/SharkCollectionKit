//
//  TestItem.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 04/04/2021.
//

import UIKit

final class TestCell: UIView, VItem {
    var viewID: String = "testing"
    
    
    //MARK: - UI
    
    weak var parentSection: Section?
    var estimatedHeight: CGFloat = 50.0
    
    private let label = UILabel()
    private let button = UIButton().with {
        $0.setTitle("Test button", for: .normal)
    }
    // MARK: -
    
    private var test: String?
    
    convenience init(test: String = "Tjos os a test") {
        self.init(frame: .zero)
        label.text = test
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
        styleView()
        
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Item

    //MARK: - Configure
    
    private func styleView(){
        backgroundColor = .white
        layer.cornerRadius = 5
        clipsToBounds = true
        layer.masksToBounds = true
        label.numberOfLines = 0
        label.textAlignment = .center
    }

    private func setConstraints(){
        HStack {
            label
        }.withHeight(350, priority: UILayoutPriority(500))
        
    }
}


final class TestCell2: UIView, VItem {
    var viewID: String = "testing2"
    
    
    //MARK: - UI
    
    var parentSection: Section?
    var estimatedHeight: CGFloat = 50.0
    
    private let label = UILabel()
    private let button = UIButton().with {
        $0.setTitle("Test button", for: .normal)
    }
    // MARK: -
    
    private var test: String?
    
    convenience init(test: String = "Tjos os a test") {
        self.init(frame: .zero)
        label.text = test
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
        styleView()
        
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Item

    //MARK: - Configure
    
    private func styleView(){
        backgroundColor = .red
        layer.cornerRadius = 5
        clipsToBounds = true
        layer.masksToBounds = true
        label.numberOfLines = 0
        label.textAlignment = .center
    }

    private func setConstraints(){
        HStack {
            label
        }.withHeight(100, priority: UILayoutPriority(500))
        
    }
}
