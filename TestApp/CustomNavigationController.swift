//
//  CustomNavigationController.swift
//  TestApp
//
//  Created by Nikita Kurochka on 19.07.2022.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func customNavigationBar(color: UIColor, isTranslucent: Bool, tintColor: UIColor){
        let navBarApperiance = UINavigationBarAppearance()
        navBarApperiance.configureWithOpaqueBackground()
        navBarApperiance.backgroundColor = color
        
        navigationBar.tintColor = tintColor
        navigationBar.isTranslucent = isTranslucent
        navigationBar.standardAppearance = navBarApperiance
        navigationBar.scrollEdgeAppearance = navBarApperiance
    }
    

}
