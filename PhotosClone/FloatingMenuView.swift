//
//  FloatingMenuView.swift
//  PhotosClone
//
//  Created by Vikash Anand on 11/05/22.
//

import UIKit

enum MenuItem {
    case years
    case months
    case days
    case allPhotos
    
    init?(_ title: String) {
        switch title {
        case "Years":
            self = .years
        case "Months":
            self = .months
        case "Days":
            self = .days
        case "All Photos":
            self = .allPhotos
        default:
            self = .allPhotos
        }
    }
}


final class FloatingMenuView: UIView {
    
    private weak var highlightViewLeadingConstraint: NSLayoutConstraint? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var menuItems: [FloatingMenuItem] = []
    private weak var lastSelectedMenuItem: FloatingMenuItem? = nil
    
    private lazy var highLightView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 14
        view.heightAnchor.constraint(equalToConstant: intrinsicContentSize.height).isActive = true
        return view
    }()
    
    private lazy var higlightViewTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        return label
    }()
    
    override var intrinsicContentSize: CGSize {
        let height = 28.0
        return CGSize(width: UIView.noIntrinsicMetric, height: height)
    }
    
    private lazy var yearsMenuItem: FloatingMenuItem = {
        let menuItem = FloatingMenuItem(with: "Years",
                                        tapActionCallback: handleTapForMenuItem)
        return menuItem
    }()
    
    private lazy var monthsMenuItem: FloatingMenuItem = {
        let menuItem = FloatingMenuItem(with: "Months",
                                        tapActionCallback: handleTapForMenuItem)
        return menuItem
    }()
    
    private lazy var daysMenuItem: FloatingMenuItem = {
        let menuItem = FloatingMenuItem(with: "Days",
                                        tapActionCallback: handleTapForMenuItem)
        return menuItem
    }()
    
    private lazy var allPhotosMenuItem: FloatingMenuItem = {
        let menuItem = FloatingMenuItem(with: "All Photos",
                                        tapActionCallback: handleTapForMenuItem)
        return menuItem
    }()
    
    private func handleTapForMenuItem(with title: String) {
        guard let menuItem: MenuItem = .init(title) else { return }
        switch menuItem {
        case .years:
            updateUI(for: yearsMenuItem)
            lastSelectedMenuItem = yearsMenuItem
           
        case .months:
            updateUI(for: monthsMenuItem)
            lastSelectedMenuItem = monthsMenuItem
            
        case .days:
            updateUI(for: daysMenuItem)
            lastSelectedMenuItem = daysMenuItem
           
        case .allPhotos:
            updateUI(for: allPhotosMenuItem)
            lastSelectedMenuItem = allPhotosMenuItem
        }
    }
    
    private func updateUI(for selectedMenuItem: FloatingMenuItem) {
        
        let newFrame = self.buttonStackView.superview!.convert(selectedMenuItem.frame, to: self)
        self.highlightViewLeadingConstraint?.constant = newFrame.minX + 5
        
        UIView.animate(withDuration: 0.16,
                       delay: 0.0,
                       options: .curveLinear,
                       animations: { [weak self] in
            guard let self = self else { return }
            self.layoutSubviews()
        }, completion: { _ in
            self.higlightViewTitleLabel.text = selectedMenuItem.title
        }
        )
    }
    
    private func configure() {
        menuItems = [yearsMenuItem, monthsMenuItem, daysMenuItem, allPhotosMenuItem]
        
        buttonStackView.addArrangedSubview(yearsMenuItem)
        buttonStackView.addArrangedSubview(monthsMenuItem)
        buttonStackView.addArrangedSubview(daysMenuItem)
        buttonStackView.addArrangedSubview(allPhotosMenuItem)
        addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            buttonStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            buttonStackView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 5),
            trailingAnchor.constraint(equalTo: buttonStackView.trailingAnchor, constant: 5),
            bottomAnchor.constraint(greaterThanOrEqualTo: buttonStackView.bottomAnchor, constant: 5)
        ])
        
        configureHighlightView()
        lastSelectedMenuItem = yearsMenuItem
    }
    
    private func configureHighlightView() {
        
        higlightViewTitleLabel.text = "Years"
        
        highLightView.addSubview(higlightViewTitleLabel)
        NSLayoutConstraint.activate([
            higlightViewTitleLabel.centerXAnchor.constraint(equalTo: highLightView.centerXAnchor),
            higlightViewTitleLabel.centerYAnchor.constraint(equalTo: highLightView.centerYAnchor),
            higlightViewTitleLabel.leadingAnchor.constraint(equalTo: highLightView.leadingAnchor, constant: 15),
            highLightView.trailingAnchor.constraint(equalTo: higlightViewTitleLabel.trailingAnchor, constant: 15)
        ])
        
        addSubview(highLightView)
        
        self.highlightViewLeadingConstraint = highLightView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5)
        NSLayoutConstraint.activate([
            highLightView.centerYAnchor.constraint(equalTo: centerYAnchor),
            self.highlightViewLeadingConstraint!,
            trailingAnchor.constraint(greaterThanOrEqualTo: highLightView.trailingAnchor, constant: 5)
        ])
    }
}

extension UIStackView {
    
    func getCenter(for subView: UIView) -> CGPoint {
        convert(subView.center, to: self)
    }
}
