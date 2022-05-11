//
//  ViewController.swift
//  PhotosClone
//
//  Created by Vikash Anand on 10/05/22.
//

import UIKit

final class LibraryViewController: UIViewController {

    private lazy var floatingMenuView: FloatingMenuView = {
        let view: FloatingMenuView = .init(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.darkGray
        view.layer.cornerRadius = 18.0
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configure()
    }

    private func configure() {
        view.backgroundColor = .red
        view.addSubview(floatingMenuView)
        view.bringSubviewToFront(floatingMenuView)
        
        NSLayoutConstraint.activate([
            floatingMenuView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            view.trailingAnchor.constraint(equalTo: floatingMenuView.trailingAnchor, constant: 15),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: floatingMenuView.bottomAnchor, constant: 12)
        ])
    }

}

