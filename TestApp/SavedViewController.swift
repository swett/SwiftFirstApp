//
//  SavedViewController.swift
//  TestApp
//
//  Created by Nikita Kurochka on 26.07.2022.
//

import UIKit

class SavedViewController: UIViewController {
    var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        closeButton = UIButton().then({ button in
            view.addSubview(button)
            button.setTitle("X", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .white
            button.layer.cornerRadius = 10
        
            button.addTarget(self, action: #selector(closeTabBar), for: .touchUpInside)
            button.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
                make.right.equalToSuperview().inset(20)
            }
        })
        
    }
    
    @objc func closeTabBar(){
        self.tabBarController?.dismiss(animated: true, completion: {
            
        })
    }

}
