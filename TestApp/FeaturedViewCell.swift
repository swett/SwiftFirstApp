//
//  FeaturedViewCell.swift
//  TestApp
//
//  Created by Nikita Kurochka on 28.07.2022.
//

import UIKit
import SDWebImage

class FeaturedViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    var label: UILabel!
    var profilePhotoView: UIImageView!
    var photo: Photoitem! {
        didSet {
            imageView.sd_setImage(with: photo.photoImage, placeholderImage: UIImage(named: "defPhoto"), completed: nil)
            profilePhotoView.sd_setImage(with: photo.profileImage, placeholderImage: UIImage(named: "defPhoto"), completed: nil)
            label.text = photo.nickName
        }
    }
    
    
    override func layoutSublayers(of layer: CALayer) {
        profilePhotoView.layer.cornerRadius = 0.5 * profilePhotoView.bounds.size.width
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView().then({ image in
            contentView.addSubview(image)
            image.backgroundColor = .red
            image.isUserInteractionEnabled = false
            image.contentMode = .scaleAspectFill
            image.clipsToBounds = true
            image.layer.cornerRadius = 10


            
            image.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
//
            
        })
        
        profilePhotoView = UIImageView().then({ profileImage in
            imageView.addSubview(profileImage)
            profileImage.clipsToBounds = true
            
            profileImage.snp.makeConstraints { make in
                make.bottom.equalToSuperview().inset(10)
                make.left.equalToSuperview().inset(20)
                make.height.equalTo(50)
                make.width.equalTo(50)
            }
        })
        
        label = UILabel().then({ label in
            imageView.addSubview(label)
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 0
            label.font = .monospacedDigitSystemFont(ofSize: 16, weight: .light)
            label.textColor = .white.withAlphaComponent(0.95)
            label.snp.makeConstraints { make in
                make.bottom.equalToSuperview().inset(20)
                make.centerX.equalToSuperview()
            }

        })
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    
}
