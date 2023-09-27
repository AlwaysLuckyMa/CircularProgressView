//
//  CircularProgressView.swift
//  HearingTest
//
//  Created by satoshi_umaM1 on 2023/7/28.
//

import UIKit

class CircularProgressView: UIView {
    private var progressLayer = CAShapeLayer()
    private var trackLayer = CAShapeLayer()

    var trackFillColor: UIColor = UIColor.clear {
        didSet {
            trackLayer.fillColor = trackFillColor.cgColor
        }
    }

    var progressFillColor: UIColor = UIColor.clear {
        didSet {
            progressLayer.fillColor = progressFillColor.cgColor
        }
    }

    var progressBgColor: UIColor = UIColor.lightGray {
        didSet {
            trackLayer.strokeColor = progressBgColor.cgColor
        }
    }

    var currentColor: UIColor = UIColor.blue {
        didSet {
            progressLayer.strokeColor = currentColor.cgColor
        }
    }

    var lineWidth: CGFloat = 10.0 {
        didSet {
            updateLayerProperties()
        }
    }

    var progress: CGFloat = 0.0 {
        didSet {
            animateProgress()
        }
    }

    private func rotateView() {
        let rotationAngle = CGFloat.pi
        transform = CGAffineTransform(rotationAngle: rotationAngle)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
        rotateView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayers()
        rotateView()
    }

    private func setupLayers() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2 - lineWidth

        let startAngle = -CGFloat.pi / 2
        let endAngle = 3 * CGFloat.pi / 2

        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: radius,
                                        startAngle: startAngle,
                                        endAngle: endAngle,
                                        clockwise: true)

        trackLayer.path = circularPath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = rgba(47, 145, 255, 1).cgColor
        trackLayer.lineWidth = lineWidth
        layer.addSublayer(trackLayer)

        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = rgba(231, 234, 238, 1).cgColor
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = 0.0
        progressLayer.lineWidth = lineWidth
        layer.addSublayer(progressLayer)
    }

    private func updateLayerProperties() {
        trackLayer.lineWidth = lineWidth
        progressLayer.lineWidth = lineWidth
        layoutSubviews()
    }

    private func animateProgress() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = progressLayer.strokeEnd
        animation.toValue = progress
        animation.duration = 0.3
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        progressLayer.strokeEnd = progress
        progressLayer.add(animation, forKey: "animateProgress")
    }
}
