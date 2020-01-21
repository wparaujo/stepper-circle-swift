//
//  CircularProgressBar.swift
//  circular-progress-bar
//
//  Created by mac on 21/01/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class StepperCircle {
    
    var scenes: [UIViewController]
    var view = StepCircularProgress()
    
    init(scenes: [UIViewController]) {
        self.scenes = scenes
    }
    
    private func isFirstStep() -> Bool {
        guard view.step == 0 else { return  false }
        return true
    }
    
    private func isLastStep() -> Bool {
        guard view.step == scenes.count - 1 else { return false }
        return true
    }
    
    func backStep() {
        let isNotFirstStep = !isFirstStep()
        guard isNotFirstStep else { return }
        let currentProgress = view.step
        view.step = currentProgress - 1
    }
    
    func goToNextStep() {
        let isNotLastStep = !isLastStep()
        guard isNotLastStep else { return }
        let currentProgress = view.step
        view.step = currentProgress + 1
    }
}



class StepCircularProgress: UIView {
    
    public var step: Int = 0 {
        didSet {
            // call action
        }
    }
    private var backgroundLayer: CAShapeLayer!
    private var foregroundLayer: CAShapeLayer!
    private var contentLayer: CAShapeLayer! // r = 80%
    private var textLayer: CATextLayer!
    private var gradientLayer: CAGradientLayer!
    
    override func draw(_ rect: CGRect) {
        let width = rect.width
        let height = rect.height
        
        let lineWidth = 0.06 * min(width, height)
        
        let center = CGPoint(x: width / 2, y: height / 2)
        let radius = (min(width, height) - lineWidth) / 2
        
        let startAngle = -(CGFloat.pi / 2)
        let endAngle = startAngle + CGFloat.pi * 2
        
        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: radius,
                                        startAngle: startAngle,
                                        endAngle: endAngle,
                                        clockwise: true)
        
        backgroundLayer = CAShapeLayer()
        backgroundLayer.path = circularPath.cgPath
        backgroundLayer.strokeColor = UIColor.lightGray.cgColor
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.lineWidth = lineWidth
        backgroundLayer.lineCap = .round
        
        foregroundLayer = CAShapeLayer()
        foregroundLayer.path = circularPath.cgPath
        foregroundLayer.strokeColor = UIColor.red.cgColor
        foregroundLayer.fillColor = UIColor.clear.cgColor
        foregroundLayer.lineWidth = lineWidth
        foregroundLayer.lineCap = .round
        foregroundLayer.strokeEnd = 1
        
        let contentCircularPath = UIBezierPath(arcCenter: center,
                                               radius: radius * 0.8,
                                               startAngle: startAngle,
                                               endAngle: endAngle,
                                               clockwise: true)
        contentLayer = CAShapeLayer()
        contentLayer.path = contentCircularPath.cgPath
//        contentLayer.backgroundColor = UIColor(red: 0.867, green: 0.875, blue: 0.89, alpha: 1).cgColor
        contentLayer.fillColor = UIColor(red: 0.867, green: 0.875, blue: 0.89, alpha: 1).cgColor
        
        let fontSize = min(width, height) / 9
        let offset = min(width, height) * 0.1
        textLayer = CATextLayer()
        textLayer.string = "Passo 1\nde 3"
//        textLayer.backgroundColor = UIColor.clear.cgColor
        textLayer.foregroundColor = UIColor(red: 0.122, green: 0.165, blue: 0.278, alpha: 1).cgColor
        textLayer.fontSize = fontSize
        textLayer.frame = CGRect(x: 0, y: (height - fontSize - offset) / 2, width: width, height: fontSize + offset + height)
        textLayer.alignmentMode = .center
        
        gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradientLayer.colors = [
          UIColor(red: 0, green: 0.4, blue: 0.651, alpha: 1).cgColor,
          UIColor(red: 0.686, green: 0.792, blue: 0.043, alpha: 1).cgColor
        ]
        gradientLayer.frame = rect
        gradientLayer.mask = foregroundLayer
        
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(gradientLayer)
        backgroundLayer.addSublayer(contentLayer)
        contentLayer.addSublayer(textLayer)
//        layer.addSublayer(textLayer)
        
    }

}
