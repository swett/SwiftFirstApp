//
//  PartyVC.swift
//  TestApp
//
//  Created by Nikita Kurochka on 25.05.2022.
//

import UIKit
import SnapKit

class PartyVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
   
    var collectionView : UICollectionView!

    var firstDarkColorOfGradient = UIColor(named: "firstDarkColorOfGradient")
    var secondDarkColorOfGradient = UIColor(named: "secondDarkColorGradient")
    var gradientLayer: CAGradientLayer!
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        .lightContent
//    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = self.view.bounds
        collectionView.frame = view.bounds
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.white.withAlphaComponent(0.5).cgColor
        self.navigationController?.navigationBar.layer.shadowRadius = 3
        self.navigationController?.navigationBar.layer.shadowOffset = .init(width: 0, height: 8)
        self.navigationController?.navigationBar.layer.shadowOpacity = 1
    }
    
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.white.withAlphaComponent(0.7)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.isTranslucent = true
        gradientLayer = CAGradientLayer().then({ v in
            self.view.layer.addSublayer(v)
            v.colors = [firstDarkColorOfGradient!.cgColor,secondDarkColorOfGradient!.cgColor]
            v.locations = [0.0, 1.0]
        })
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width:view.frame.width-40,height: view.frame.height-200)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then({ collectionView in
            view.addSubview(collectionView)
            collectionView.backgroundColor = .clear
            collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
           
        })

        guard collectionView != nil else {
            return
        }


    }
    

    
    func showBottomSheet () {
        let vc = HalfScreenPresintationView()
         vc.modalPresentationStyle = .overCurrentContext
         self.present(vc, animated: false)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AppData.shared.pidorsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.pidor = AppData.shared.pidorsArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let myCell = cell as! CustomCell
//        myCell.animationText()
        myCell.layer.shadowOffset = .init(width: 0, height: 10)
        myCell.layer.shadowRadius = 5
        myCell.layer.shadowColor = UIColor.white.withAlphaComponent(0.3).cgColor
        myCell.layer.shadowOpacity = 1

        UIView.animate(withDuration: 0.9, delay: 0, options: [.autoreverse, .curveEaseInOut]) {
            myCell.imageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        } completion: { com in
            myCell.imageView.transform = CGAffineTransform(translationX: 1, y: 1)
        }

        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // commented for if i want add to photo some text this action how to call somthing on cell
       

//        showBottomSheet()
        let vc = HalfScreenPresintationView()
         vc.modalPresentationStyle = .overCurrentContext
         self.present(vc, animated: false)
        vc.pidor = AppData.shared.pidorsArray[indexPath.row]
        
                // animation for text on photo disabled cuz added bottom sheet
//        myCell.showHiddenText()
    }
    
    
    
    
}
