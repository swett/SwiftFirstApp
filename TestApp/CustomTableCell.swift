//
//  CustomTableCell.swift
//  TestApp
//
//  Created by Nikita Kurochka on 28.06.2022.
//

import UIKit

class CustomTableCell: UITableViewCell {
    var containerView: UIView!
    var photoLable: UIImageView!
    var textedLabel: UILabel!
    var pidor: PidorItem! {
        didSet{
            //there data from app data going to their place for visible
            textedLabel.text = pidor.text
            containerView.backgroundColor = UIColor.color(withData: pidor.color)
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
       
        containerView = UIView().then({ container in
            contentView.addSubview(container)
            container.layer.cornerRadius = 10
            container.snp.makeConstraints { make in
                make.left.top.right.equalToSuperview()
                make.height.equalTo(Int.random(in: 60...100)).priority(800)
                make.bottom.equalToSuperview().inset(10)
            }
        })
        
        textedLabel = UILabel().then({ textedLabel in
            containerView.addSubview(textedLabel)
            textedLabel.textColor = .white
            textedLabel.numberOfLines = 0
            textedLabel.adjustsFontSizeToFitWidth = true
            textedLabel.backgroundColor = .clear
            textedLabel.textAlignment = .center
            textedLabel.snp.makeConstraints { make in
                make.centerX.centerY.equalToSuperview()
                make.left.right.equalToSuperview().inset(15)
                
                
            }
        })
        
        
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

