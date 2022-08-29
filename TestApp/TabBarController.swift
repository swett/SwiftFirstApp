//
//  TabBarController.swift
//  TestApp
//
//  Created by Nikita Kurochka on 26.07.2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        let featured = FeaturedViewController()
        featured.title = "Featured"
        featured.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        let saved = SavedViewController()
        saved.title = "Saved"
        saved.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 1)
        let controllers = [featured, saved]
        self.viewControllers = controllers
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        
    }
    

 

}
