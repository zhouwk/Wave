//
//  WaveView.swift
//  Wave
//
//  Created by 周伟克 on 2020/7/2.
//  Copyright © 2020 周伟克. All rights reserved.
//

import UIKit

class WaveView: UIView {

    var speed = CGFloat(0)
    var bSpeed = CGFloat(90)

    var waveTimer: CADisplayLink!
    
    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        let firstPath = UIBezierPath()
        // 假设一个正弦周期(2π)对应于rect.width，则每个pt对应的弧度
        let radianPerPt = 2 * CGFloat.pi / rect.width
        speed += 5
        for x in 0 ... Int(rect.width) {
            let floatX = CGFloat(x)
            let y = -5 * sin(floatX * radianPerPt + speed * radianPerPt) + rect.height * 0.5
            let point = CGPoint(x: floatX, y: y)
            if  x == 0 {
                firstPath.move(to: point)
            } else {
                firstPath.addLine(to: point)
            }
        }
        firstPath.addLine(to: CGPoint(x: rect.width, y: rect.height))
        firstPath.addLine(to: CGPoint(x: 0, y: rect.height))
        firstPath.close()
        ctx?.addPath(firstPath.cgPath)
        ctx?.setFillColor(UIColor.green.withAlphaComponent(0.1).cgColor)
        ctx?.fillPath()
        
        let secondPath = UIBezierPath()
        bSpeed += 5
        for x in 0 ... Int(rect.width) {
            let floatX = CGFloat(x)
            let y = -8 * sin(floatX * radianPerPt * 1.2 + bSpeed * radianPerPt) + rect.height * 0.5
            let point = CGPoint(x: floatX, y: y)
            if x == 0 {
                secondPath.move(to: point)
            } else {
                secondPath.addLine(to: point)
            }
        }
        secondPath.addLine(to: CGPoint(x: rect.width, y: rect.height))
        secondPath.addLine(to: CGPoint(x: 0, y: rect.height))
        secondPath.close()
        ctx?.addPath(secondPath.cgPath)
        ctx?.setFillColor(UIColor.green.withAlphaComponent(0.3).cgColor)
        ctx?.fillPath()

        
    }
        
    @objc func redrawWave() {
        setNeedsDisplay()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        waveTimer = CADisplayLink(target: self, selector: #selector(redrawWave))
        waveTimer.add(to: .current, forMode: .common)
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        waveTimer?.invalidate()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}
