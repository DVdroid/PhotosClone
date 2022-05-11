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
            updateUI(for: yearsMenuItem,
                     unselectedMenuItem: [monthsMenuItem, daysMenuItem, allPhotosMenuItem])
           
        case .months:
            updateUI(for: monthsMenuItem,
                     unselectedMenuItem: [yearsMenuItem, daysMenuItem, allPhotosMenuItem])
            
        case .days:
            updateUI(for: daysMenuItem,
                     unselectedMenuItem: [yearsMenuItem, monthsMenuItem, allPhotosMenuItem])
           
        case .allPhotos:
            updateUI(for: allPhotosMenuItem,
                     unselectedMenuItem: [yearsMenuItem, monthsMenuItem, daysMenuItem])
        }
    }
    
    private func updateUI(for selectedMenuItem: FloatingMenuItem,
                          unselectedMenuItem: [FloatingMenuItem]) {
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: {
            selectedMenuItem.selectItem()
            for menuItem in unselectedMenuItem {
                menuItem.unselectItem()
            }
        },
                       completion: nil)
    }
    
    private func configure() {
        menuItems = [yearsMenuItem, monthsMenuItem, daysMenuItem, allPhotosMenuItem]
        highlightYearsMenuItem()
        
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
    }
    
    private func highlightYearsMenuItem() {
        yearsMenuItem.selectItem()
        monthsMenuItem.unselectItem()
        daysMenuItem.unselectItem()
        allPhotosMenuItem.unselectItem()
    }
}
