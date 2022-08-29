//
//  ShowHeroScreen.swift
//  TestApp
//
//  Created by Nikita Kurochka on 03.07.2022.
//

import UIKit

class ShowHeroScreen: UIViewController {

    var imageView: UIImageView!
    var titleLabel: UILabel!
    var photoName: String!
    var text: String!
    let maxDimmedAlpha: CGFloat = 0.65
    var dimmedView: UIView!
    var blurView: UIView!
    let defaultHeight: CGFloat = 820
    var containerView: UIView!
    var closeButton: UIButton!
    var pidor: PidorItem!
//    {
//        didSet {
//            if titleLabel != nil {
//                titleLabel.text = pidor.text
//            }
//            if imageView != nil {
//                imageView.image = UIImage(named: pidor.image)
//            }
//        }
//    }
    var bgView: UIView!
    convenience init(pidor: PidorItem) {
        self.init()
        self.pidor = pidor
    }
    
    
//    func customInit(photoName: String, title: String) {
//
//            self.photoName = photoName
//            self.text = title
//        }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateShowDimmedView()
        animatePresentContainer()
        firstShowCard()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bgView.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        bgView.layer.shadowRadius = 5
        bgView.layer.shadowOffset = .init(width: 0, height: 5)
        bgView.layer.shadowOpacity = 1
        closeButton.layer.cornerRadius = 0.5 * closeButton.bounds.size.width
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        
        blurView = UIView().then({ blur in
            view.addSubview(blur)
            blur.backgroundColor = .clear
            blur.addBlurredBackground(style: .systemUltraThinMaterialDark)
            blur.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
            }
        })
        
        dimmedView = UIView().then({ dimmed in
            view.addSubview(dimmed)
            dimmed.backgroundColor = .black
            dimmed.alpha = maxDimmedAlpha
            dimmed.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
            }
        })
        containerView = UIView().then({ container in
            view.addSubview(container)
            container.backgroundColor = .clear
            container.layer.cornerRadius = 16
            container.clipsToBounds = false
            container.snp.makeConstraints { make in
                make.height.equalTo(0)
                make.left.right.equalToSuperview()
                make.bottom.equalToSuperview()
            }
        })
        
        closeButton = UIButton().then({ button in
            containerView.addSubview(button)
            button.backgroundColor = .purple
            button.setTitle("X", for: .normal)
            button.titleLabel?.font = UIFont.monospacedSystemFont(ofSize: 18, weight: .thin)
            button.addTarget(self, action:#selector(buttonTapped) , for: .touchUpInside)
            button.snp.makeConstraints { make in
                make.top.equalTo(containerView.snp.top).inset(-15)
                make.right.equalToSuperview().inset(20)
                make.height.equalTo(30)
                make.width.equalTo(30)
            }
        })
        
        bgView = UIView().then({ bg in
            containerView.addSubview(bg)
            bg.layer.cornerRadius = 10
            bg.snp.makeConstraints { make in
                make.top.equalTo(containerView).offset(70)
                make.left.right.equalToSuperview().inset(30)
                make.height.equalTo(550)
            }
            
        })
        
        
        imageView = UIImageView().then({ image in
            bgView.addSubview(image)
            image.image = UIImage(data: pidor.image)
            image.isUserInteractionEnabled = true
            image.contentMode = .scaleAspectFill
            image.clipsToBounds = true
            image.layer.cornerRadius = 10
            image.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture)))
            image.addGestureRecognizer(UIRotationGestureRecognizer(target: self, action: #selector(self.handleRotateGesture)))
            image.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(self.handlePinchGesture)))
            image.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
//          
        })
        
        
        titleLabel = UILabel().then({ label in
            imageView.addSubview(label)
            label.numberOfLines = 0
            label.textColor = .white
            label.text = pidor.text
            label.font = .monospacedDigitSystemFont(ofSize: 25, weight: .thin)
            label.snp.makeConstraints { make in
                
                make.height.equalTo(100)
                make.centerX.equalToSuperview()
                make.left.right.equalToSuperview().inset(15)
                make.bottom.equalToSuperview()
            }
        })
        
        
    }
    
    
    @objc func handlePinchGesture(gesture: UIPinchGestureRecognizer){
        if gesture.state == .began {
            print("began")
        } else if gesture.state == .changed {
            let scale = gesture.scale
            print(scale)
            if scale > 0.8 && scale < 1.2 {
                bgView.transform = CGAffineTransform(scaleX: scale, y: scale )
            }
        } else if gesture.state == .ended {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
                self.bgView.transform = .identity
            } completion: { com in
                
            }

        }
    }
    
    @objc func handleRotateGesture(gesture: UIRotationGestureRecognizer){
        if gesture.state == .began {
            print("began")
        } else if gesture.state == .changed {
            let rotation = gesture.rotation
//            print(rotation)
            if rotation > -1.5 && rotation < 1.5{
                bgView.transform = CGAffineTransform(rotationAngle: rotation * ((1.5 - abs(rotation))/1.5))
            }
        } else if gesture.state == .ended {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
                self.bgView.transform = .identity
            } completion: { com in
                
            }

        }
    }
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer){
        
        if gesture.state == .began {
            print("began")
        } else if gesture.state == .changed {
            let translation = gesture.translation(in: self.view)
            
            
// good transition
            
//            print(translation.x, translation.y)
//            if translation.x > 200 || translation.y > 200 || translation.x < -200 || translation.y < -200 {
//                self.imageView.transform = CGAffineTransform(translationX:translation.x * 0.5, y: translation.y * 0.5)
//            } else if translation.x > 400 || translation.y > 400 || translation.x < -400 || translation.y < -400 {
//                self.imageView.transform = CGAffineTransform(translationX:translation.x * 0.15, y: translation.y * 0.15)
//            } else {
            self.bgView.transform = CGAffineTransform(translationX:translation.x * ((300 - abs(translation.x))/300), y: translation.y * ((400 - abs(translation.y))/400))
            
//            }
// fun trnsition
            //            self.imageView.transform = CGAffineTransform(rotationAngle: translation.x)
//           3d rotation
//            self.imageView.layer.transform = CATransform3DMakeRotation(translation.y, 0, 1, 0)
        } else if gesture.state == .ended {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
                self.bgView.transform = .identity
            } completion: { com in
                
            }

        }
    }
    
    func firstShowCard () {
        let angleRotate = Float.random(in: -0.3...0.3)
        let scaleByX = Float.random(in: 0.8...1.2)
        let scaleByY = Float.random(in: 0.8...1.2)
        bgView.transform = CGAffineTransform.init(rotationAngle: CGFloat(angleRotate)).concatenating(CGAffineTransform.init(scaleX: CGFloat(scaleByX), y: CGFloat(scaleByY)))
    }
    
    func animateShowDimmedView () {
        blurView.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.blurView.alpha = 1
        }
        dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = self.maxDimmedAlpha
        }
    }
    func animatePresentContainer(){
        UIView.animate(withDuration: 0.3) {
            self.containerView.snp.remakeConstraints { make in
                make.height.equalTo(self.defaultHeight)
                make.bottom.equalToSuperview()
                make.left.right.equalToSuperview()
            }
            self.view.layoutIfNeeded()
        }
    }

    func animateDismissView() {
        UIView.animate(withDuration: 0.4) {
            self.imageView.snp.remakeConstraints { make in
                make.edges.equalTo(0)
            }
        }
        UIView.animate(withDuration: 0.5) {
            self.containerView.snp.remakeConstraints { make in
                make.bottom.equalTo(self.defaultHeight)
                make.right.left.equalToSuperview()
            }
            self.view.layoutIfNeeded()
        }
        dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.6) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: true)
        }
        blurView.alpha = 1
        UIView.animate(withDuration: 0.7) {
            self.blurView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: true)
        }

    }
    @objc func buttonTapped() {
        animateDismissView()
    }
    
    
}

extension UIView {
    func addBlurredBackground(style: UIBlurEffect.Style) {
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.frame
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurView)
        self.sendSubviewToBack(blurView)
    }
}
