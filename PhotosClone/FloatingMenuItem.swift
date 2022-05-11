//
//  FloatingMenuItem.swift
//  PhotosClone
//
//  Created by Vikash Anand on 11/05/22.
//

import UIKit

final class FloatingMenuItem: UIView {
    
    private var title: String = ""
    private var tapActionCallback: ((String) -> Void)? = nil
    init(with title: String, tapActionCallback:((String) -> Void)?) {
        super.init(frame: .zero)
        self.title = title
        self.title = title
        self.tapActionCallback = tapActionCallback
        configure()
    }
    
    @available(*, unavailable)
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func configure() {
        backgroundColor = .lightGray
        layer.cornerRadius = 14
        titleLabel.text = title
        titleLabel.textColor = UIColor.white
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 5),
            trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 15),
            bottomAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: 5)
        ])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        addGestureRecognizer(tap)
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        tapActionCallback?(title)
    }
    
    func selectItem() {
        titleLabel.textColor = UIColor.white
        backgroundColor = .lightGray
    }
    
    func unselectItem() {
        titleLabel.textColor = UIColor.lightGray
        backgroundColor = .darkGray
    }
}
