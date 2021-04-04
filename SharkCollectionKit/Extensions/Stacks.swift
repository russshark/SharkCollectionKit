//
//  Stacks.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 04/04/2021.
//

import UIKit

// MARK: - Stacks

extension UIView {
    
    fileprivate func _stack(_ axis: NSLayoutConstraint.Axis = .vertical, views: [UIView], spacing: CGFloat = .zero, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill, usingSafeArea: Bool = true) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.alignment = alignment
        stackView.distribution = distribution
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: .zero),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .zero),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: .zero),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .zero)
        ])
        return stackView
    }
    
    @discardableResult
    func vstack(_ views: UIView..., spacing: CGFloat = .zero, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill, usingSafeArea: Bool = true) -> UIStackView {
        return _stack(.vertical, views: views, spacing: spacing, alignment: alignment, distribution: distribution, usingSafeArea: usingSafeArea)
    }
    
    @discardableResult
    func hstack(_ views: UIView..., spacing: CGFloat = .zero, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill) -> UIStackView {
        return _stack(.horizontal, views: views, spacing: spacing, alignment: alignment, distribution: distribution)
    }
    
    @discardableResult
    func setHeight(_ height: CGFloat) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult
    func setWidth(_ width: CGFloat) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    @discardableResult
    func setSize(_ size: CGSize) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        return self
    }
}

extension UIStackView {

    @discardableResult
    func margin(_ margins: UIEdgeInsets) -> UIStackView {
        layoutMargins = margins
        isLayoutMarginsRelativeArrangement = true
        return self
    }
}

final class Space: UIView {
    
    // This is for making spaces within a stack view easier
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
    }
    
    init(h: CGFloat) {
        super.init(frame: .zero)
        setHeight(h)
    }
    
    init(w: CGFloat) {
        super.init(frame: .zero)
        setWidth(w)
    }

    required public init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
