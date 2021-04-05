//
//  Stacks.swift
//  SharkCollectionKit
//
//  Created by Russell Warwick on 04/04/2021.
//

import UIKit

// MARK: - Stacks



extension UIView {
    
    @discardableResult
    func withSqaure(_ value: CGFloat, priority: UILayoutPriority = .required) -> Self {
        return withFixed(width: value, height: value, priority: priority)
    }
    
    @discardableResult
    func withWidth(_ value: CGFloat, priority: UILayoutPriority = .required) -> Self {
        return withFixed(width: value, height: nil, priority: priority)
    }
    
    @discardableResult
    func withHeight(_ value: CGFloat, priority: UILayoutPriority = .required) -> Self {
        return withFixed(width: nil, height: value, priority: priority)
    }
    
    @discardableResult
    func withFixed(width: CGFloat? = nil, height: CGFloat? = nil, priority: UILayoutPriority = .required) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([width.flatMap { widthAnchor.constraint(equalToConstant: $0) },
                                     height.flatMap { heightAnchor.constraint(equalToConstant: $0)}]
                                    .compactMap { $0?.priority = priority
                                        return $0
                                    })
        
        return self
    }
    
    // MARK: - Stacks
    
    fileprivate func _stack(_ axis: NSLayoutConstraint.Axis = .vertical, views: [UIView], spacing: CGFloat = .zero, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill, safeArea: Bool = true) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.alignment = alignment
        stackView.distribution = distribution
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        if safeArea {
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: .zero),
                stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: .zero),
                stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: .zero),
                stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: .zero)
            ])
        } else {
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: topAnchor, constant: .zero),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .zero),
                stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: .zero),
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .zero)
            ])
        }

        return stackView
    }
    
    @discardableResult
    func zstack(spacing: CGFloat = .zero, safeArea: Bool = false, @GenericArrayBuilder<UIView> views: () -> [UIView])-> UIView {
        let stack = vstack{}
        
        let _ = views().map { (view: UIView) in
            stack.vstack { view }
        }
        
        return stack
    }
    
    @discardableResult
    func vstack(spacing: CGFloat = .zero, safeArea: Bool = false, @GenericArrayBuilder<UIView> views: () -> [UIView])-> UIStackView {
        return _stack(.vertical, views: views(), spacing: spacing, alignment: .fill, distribution: .fill, safeArea: safeArea)
    }
    
    @discardableResult
    func hstack(spacing: CGFloat = .zero, safeArea: Bool = false, @GenericArrayBuilder<UIView> views: () -> [UIView])-> UIStackView {
        return _stack(.horizontal, views: views(), spacing: spacing, alignment: .fill, distribution: .fill, safeArea: safeArea)
    }

}

extension UIStackView {

    @discardableResult
    func margin(_ margins: UIEdgeInsets) -> UIStackView {
        layoutMargins = margins
        isLayoutMarginsRelativeArrangement = true
        return self
    }

    @discardableResult
    func alignment(_ alignment: UIStackView.Alignment) -> UIStackView {
        self.alignment = alignment
        return self
    }
    
    @discardableResult
    func distribution(_ distribution: UIStackView.Distribution) -> UIStackView {
        self.distribution = distribution
        return self
    }
}

final class Space: UIView {

    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
    }
    
    init(h: CGFloat) {
        super.init(frame: .zero)
        withHeight(h)
    }
    
    init(w: CGFloat) {
        super.init(frame: .zero)
        withWidth(w)
    }

    required public init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
