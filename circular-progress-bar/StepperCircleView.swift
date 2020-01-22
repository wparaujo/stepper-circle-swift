//
//  CircularProgressBar.swift
//  circular-progress-bar
//
//  Created by mac on 21/01/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class StepperCircleView: UIView {
    
    public var currentStep: Int = 1 {
        didSet {
            updateProgressStep()
        }
    }
    
    var currentProgress: CGFloat {
        return CGFloat(CGFloat(currentStep) / CGFloat(totalSteps))
    }
    
    public var totalSteps: Int = 6
    public var currentStatus: String = ""
    
    private var foregroundLayer: CAShapeLayer!
    private var contentLayer: CAShapeLayer! // r = 80%
    private var textStatusLayer: CATextLayer!
    private var gradientLayer: CAGradientLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        currentStep = 6
        currentStatus = "Passo \(currentStep)\nde \(totalSteps)"
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        currentStep = 6
        currentStatus = "Passo \(currentStep)\nde \(totalSteps)"
    }
    
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
        
        foregroundLayer = CAShapeLayer()
        foregroundLayer.path = circularPath.cgPath
        foregroundLayer.strokeColor = UIColor.red.cgColor
        foregroundLayer.fillColor = UIColor.clear.cgColor
        foregroundLayer.lineWidth = lineWidth
        foregroundLayer.lineCap = .round
        foregroundLayer.strokeEnd = currentProgress
        
        let contentCircularPath = UIBezierPath(arcCenter: center,
                                               radius: radius * 0.8,
                                               startAngle: startAngle,
                                               endAngle: endAngle,
                                               clockwise: true)
        contentLayer = CAShapeLayer()
        contentLayer.path = contentCircularPath.cgPath
        contentLayer.fillColor = UIColor(red: 0.867, green: 0.875, blue: 0.89, alpha: 1).cgColor
        
        let fontSize = min(width, height) / 9
        let offset = min(width, height) * 0.1
        textStatusLayer = CATextLayer()
        textStatusLayer.string = currentStatus
        textStatusLayer.foregroundColor = UIColor(red: 0.122, green: 0.165, blue: 0.278, alpha: 1).cgColor
        textStatusLayer.fontSize = fontSize
        textStatusLayer.frame = CGRect(x: 0, y: (height - fontSize - offset) / 2, width: width, height: fontSize + offset + height)
        textStatusLayer.alignmentMode = .center
        
        gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradientLayer.colors = [
          UIColor(red: 0, green: 0.4, blue: 0.651, alpha: 1).cgColor,
          UIColor(red: 0.686, green: 0.792, blue: 0.043, alpha: 1).cgColor
        ]
        gradientLayer.frame = rect
        gradientLayer.mask = foregroundLayer
        
        layer.addSublayer(gradientLayer)
        layer.addSublayer(contentLayer)
        contentLayer.addSublayer(textStatusLayer)
    }
    
    private func updateProgressStep() {
        foregroundLayer.strokeEnd = currentProgress
    }
    
    // MARK: - Layers Makers
    
    private func createProgressLayer(path: CGPath, lineWidth: CGFloat) -> CAShapeLayer {
        let foregroundLayer = CAShapeLayer()
        foregroundLayer.path = path
        foregroundLayer.strokeColor = UIColor.red.cgColor
        foregroundLayer.fillColor = UIColor.clear.cgColor
        foregroundLayer.lineWidth = lineWidth
        foregroundLayer.lineCap = .round
        foregroundLayer.strokeEnd = currentProgress
        return foregroundLayer
    }
    
    private func createContentLayer(path: CGPath) -> CAShapeLayer {
        let contentLayer = CAShapeLayer()
        contentLayer.path = path
        contentLayer.fillColor = UIColor(red: 0.867, green: 0.875, blue: 0.89, alpha: 1).cgColor
        return contentLayer
    }
    
    private func createTextStatusLayer(rect: CGRect, fontSize: CGFloat) -> CATextLayer {
        
        let width = rect.width
        let height = rect.height
        
        let fontSize = min(width, height) / 9
        let offset = min(width, height) * 0.1
        let textLayer = CATextLayer()
        textLayer.string = currentStatus
        textLayer.foregroundColor = UIColor(red: 0.122, green: 0.165, blue: 0.278, alpha: 1).cgColor
        textLayer.fontSize = fontSize
        textLayer.frame = CGRect(x: 0, y: (height - fontSize - offset) / 2, width: width, height: fontSize + offset + height)
        textLayer.alignmentMode = .center
        return textLayer
    }
    
    private func configureGradient(_ rect: CGRect, forLayer layer: CAShapeLayer) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradientLayer.colors = [ UIColor(red: 0, green: 0.4, blue: 0.651, alpha: 1).cgColor,
                                 UIColor(red: 0.686, green: 0.792, blue: 0.043, alpha: 1).cgColor
                                ]
        gradientLayer.frame = rect
        gradientLayer.mask = layer
        return gradientLayer
    }
    
    private func setupSublayers() {
        
    }
}
