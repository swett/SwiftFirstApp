//
//  CustomCell.swift
//  TestApp
//
//  Created by Nikita Kurochka on 25.05.2022.
//

import UIKit
import SnapKit

class CustomCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    var label: UILabel!
    
    var pidor: PidorItem! {
        didSet{
            //there data from app data going to their place for visible
            imageView.image = UIImage(data: pidor.image)
//            label.text = pidor.text
//            self.label.alpha = 0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tapGestureRecognizer = UIGestureRecognizer(target: self, action: #selector(showHiddenText))
        imageView = UIImageView().then({ image in
            contentView.addSubview(image)
            image.backgroundColor = .red
            image.isUserInteractionEnabled = false
            image.contentMode = .scaleAspectFill
            image.clipsToBounds = true
            image.layer.cornerRadius = 10
//            image.layer.borderWidth = 5
//            image.layer.borderColor = UIColor.darkGray.withAlphaComponent(0.5).cgColor

            image.addGestureRecognizer(tapGestureRecognizer)
            image.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
//
            
        })
//        label = UILabel().then({ label in
//            label.frame = CGRect(x: 30, y: 350, width: 300, height: 100)
//            label.lineBreakMode = .byWordWrapping
//            label.numberOfLines = 0
//            label.textColor = .white
//            contentView.addSubview(label)
//            
//        })
        
    }
    @objc func showHiddenText () {
        print("tapped photo")
        UIView.animate(withDuration: 0.1) {
            self.imageView.transform = .init(scaleX: 0.85, y: 0.85)
        } completion: { com in
            UIView.animate(withDuration: 0.1) {
                self.imageView.transform = .identity
            }
        }
        
       

    }
   

    
//    func animationText () {
//        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
//            self.label.alpha = 1
//            
//        } completion: { finished in
//            print("showed text")
//        }
//
//    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var bounds: CGRect {
        didSet {
            contentView.frame = bounds
        }
    }
    
}
