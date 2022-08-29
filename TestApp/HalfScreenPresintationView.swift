//
//  HalfScreenPresintationView.swift
//  TestApp
//
//  Created by Nikita Kurochka on 31.05.2022.
//

import UIKit

class HalfScreenPresintationView: UIViewController {

    var containerView: UIView!
    let maxDimmedAlpha: CGFloat = 0.6
    var dimmedView: UIView!
    let defaultHeight: CGFloat = 300
    var titleLabel: UILabel!
    var pidor: PidorItem! {
        didSet{
            titleLabel.text = pidor.text
            self.titleLabel.alpha = 0
        }
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateShowDimmedView()
        animatePresentContainer()
        animationText()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        
      
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
            container.backgroundColor = .white
            container.layer.cornerRadius = 16
            container.clipsToBounds = true
            container.snp.makeConstraints { make in
                make.height.equalTo(0)
                make.left.right.equalToSuperview()
                make.bottom.equalToSuperview()
            }
        })
        titleLabel = UILabel().then({ titleLabel in
            containerView.addSubview(titleLabel)
            titleLabel.text = "Hello YEban"
            titleLabel.textColor = .darkGray
            titleLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 19, weight: .light)
            titleLabel.numberOfLines = 0
            titleLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(90)
                make.centerX.equalToSuperview()
                make.left.right.equalToSuperview().inset(20)
            }
        })
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleCloseAction))
        dimmedView.addGestureRecognizer(tapGesture)
        
        setupPanGesture()
        
    }
    
    
    func animationText () {
        UIView.animate(withDuration: 0.9, delay: 0, options: .curveEaseIn) {
            self.titleLabel.alpha = 1
            
        } completion: { finished in
            print("showed text")
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
    func animateShowDimmedView () {
        dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = self.maxDimmedAlpha
        }
    }

    func animateDismissView() {
        UIView.animate(withDuration: 0.3) {
            self.containerView.snp.remakeConstraints { make in
                make.bottom.equalTo(self.defaultHeight)
                make.right.left.equalToSuperview()
            }
            self.view.layoutIfNeeded()
        }
        dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: true)
        }

    }
    
    @objc func handleCloseAction() {
        animateDismissView()
    }
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        // code for make draggible bottom sheet
        
        //        let translation = gesture.translation(in: view)
//              // Drag to top will be minus value and vice versa
//              print("Pan gesture y offset: \(translation.y)")
//
//              // Get drag direction
//              let isDraggingDown = translation.y > 0
//              print("Dragging direction: \(isDraggingDown ? "going down" : "going up")")
//
//              // New height is based on value of dragging plus current container height
//              let newHeight = currentContainerHeight - translation.y
//
//              // Handle based on gesture state
//              switch gesture.state {
//              case .changed:
//                  // This state will occur when user is dragging
//                  if newHeight < maximumContainerHeight {
//                      // Keep updating the height constraint
//                      containerViewHeightConstraint?.constant = newHeight
//                      // refresh layout
//                      view.layoutIfNeeded()
//                  }
//              case .ended:
//                  // This happens when user stop drag,
//                  // so we will get the last height of container
//
//                  // Condition 1: If new height is below min, dismiss controller
//                  if newHeight < dismissibleHeight {
//                      self.animateDismissView()
//                  }
//                  else if newHeight < defaultHeight {
//                      // Condition 2: If new height is below default, animate back to default
//                      animateContainerHeight(defaultHeight)
//                  }
//                  else if newHeight < maximumContainerHeight && isDraggingDown {
//                      // Condition 3: If new height is below max and going down, set to default height
//                      animateContainerHeight(defaultHeight)
//                  }
//                  else if newHeight > defaultHeight && !isDraggingDown {
//                      // Condition 4: If new height is below max and going up, set to max height at top
//                      animateContainerHeight(maximumContainerHeight)
//                  }
//              default:
//                  break
//              }
    }
    
    func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }
        
    }
        

            
    
    
    
        

