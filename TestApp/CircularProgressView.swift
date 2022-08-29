//
//  CircularProgressView.swift
//  TestApp
//
//  Created by Nikita Kurochka on 13.06.2022.
//

import UIKit

class CircularProgressView: UIView {

     var processLayer = CAShapeLayer()
     var trackLayer = CAShapeLayer()
    var innerColor: UIColor!
    var outerColor: UIColor!
    
    convenience init(innerColor: UIColor, outerColor: UIColor) {
        self.init()
        self.innerColor = innerColor
        self.outerColor = outerColor
   
    }
    
//    override init(frame: CGRect){
//        super.init(frame: frame)
//
//
//    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawCirculesShapes()
    }
    
    func createCircleShapeLayer(strokeColor: UIColor, fillColor: UIColor) -> CAShapeLayer{
        let layer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width/2, y: frame.size.width/2), radius: (frame.size.width - 1.5)/2, startAngle:CGFloat(-0.5 * .pi), endAngle: 1.5 * CGFloat.pi, clockwise: true)
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = 10
        layer.fillColor = fillColor.cgColor
        layer.lineCap = .round
        return layer
    }
    
    func drawCirculesShapes(){
        processLayer = createCircleShapeLayer(strokeColor: innerColor, fillColor: UIColor.clear)
        layer.addSublayer(processLayer)
        trackLayer = createCircleShapeLayer(strokeColor: outerColor, fillColor: UIColor.clear)
        trackLayer.strokeEnd = 0
//        trackLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        layer.addSublayer(trackLayer)
    }

}
