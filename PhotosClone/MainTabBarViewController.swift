//
//  MainTabBarViewController.swift
//  PhotosClone
//
//  Created by Vikash Anand on 10/05/22.
//

import UIKit

final class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        tabBar.backgroundColor = .darkGray
        tabBar.barTintColor = .lightGray
        configureTabBarViewControllers()
    }
    
    private func configureTabBarViewControllers() {
        
        let libraryViewController:LibraryViewController = .init()
        let libraryTabItem: UITabBarItem = .init(title: "Library",
                                                 image: .init(systemName: "photo.on.rectangle"),
                                                 selectedImage:  .init(systemName: "photo.on.rectangle")?.withTintColor(.blue))
        libraryViewController.tabBarItem = libraryTabItem
        
        let forYouViewController: ForYouViewController = .init()
        let forYouTabItem: UITabBarItem = .init(title: "For You",
                                                image: .init(systemName: "heart.text.square"),
                                                selectedImage:  .init(systemName: "heart.text.square")?.withTintColor(.blue))
        forYouViewController.tabBarItem = forYouTabItem
        
        let albumsViewController: AlbumsViewController = .init()
        let albumsTabItem: UITabBarItem = .init(title: "Albums",
                                                image: .init(systemName: "rectangle.stack.fill"),
                                                selectedImage:  .init(systemName: "rectangle.stack.fill")?.withTintColor(.blue))
        albumsViewController.tabBarItem = albumsTabItem
        
        let searchViewController: SearchhViewController = .init()
        let searchTabItem: UITabBarItem = .init(title: "Search",
                                                image: .init(systemName: "magnifyingglass"),
                                                selectedImage:  .init(systemName: "magnifyingglass")?.withTintColor(.blue))
        searchViewController.tabBarItem = searchTabItem
        
        
        self.viewControllers = [libraryViewController, forYouViewController, albumsViewController, searchViewController]
    }
}

extension MainTabBarViewController: UITabBarControllerDelegate {
    
}
