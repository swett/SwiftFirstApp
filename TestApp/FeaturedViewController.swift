//
//  FeaturedViewController.swift
//  TestApp
//
//  Created by Nikita Kurochka on 26.07.2022.
//

import UIKit
import Alamofire
class FeaturedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    
    
    var closeButton: UIButton!
    let fetchData = APIService()
    var collectionView: UICollectionView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        fetchData.fetchData(completion:{success in print(success)
            self.collectionView.reloadData()
            self.animate()
        })
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
        //collectionView
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width:view.frame.width-40,height: view.frame.height-200)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then({ collectionView in
            view.addSubview(collectionView)
            collectionView.backgroundColor = .clear
            collectionView.register(FeaturedViewCell.self, forCellWithReuseIdentifier: "cell")
            collectionView.alpha = 0
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.snp.makeConstraints { make in
                make.top.equalTo(closeButton.snp.bottom).offset(20)
                make.left.right.bottom.equalToSuperview()
            }
           
        })
        guard collectionView != nil else {
            return
        }

        // Do any additional setup after loading the view.
    }
    @objc func closeTabBar(){
        self.tabBarController?.dismiss(animated: true, completion: {
            
        })
    }
    
    func animate() {
        UIView.animate(withDuration: 0.3) {
            self.collectionView.alpha = 1
        } completion: { com in
            
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AppData.shared.photosArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FeaturedViewCell
        
        cell.photo = AppData.shared.photosArray[indexPath.row]
        return cell
    }
    

}
