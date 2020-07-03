//
//  ProgressView.swift
//  Progress
//
//  Created by 周伟克 on 2020/7/2.
//  Copyright © 2020 周伟克. All rights reserved.
//

import UIKit

class ProgressView: UIView {
    
    var progress = 0.0 {
        didSet {
            if progress < 0 {
                progress = 0
            } else if progress > 1 {
                progress = 1
            }
//            setNeedsDisplay()
        }
    }
    
    var speed = CGFloat(0)
    var waveTimer: CADisplayLink!
    
    override func draw(_ rect: CGRect) {
                
        let ctx = UIGraphicsGetCurrentContext()
        let wavePath = UIBezierPath()
        // 假设一个正弦周期(2π)对应于rect.width，则每个pt对应的弧度
        let radianPerPt = 2 * CGFloat.pi / rect.width
        speed += 2
        for x in 0 ... Int(rect.width) {
            let floatX = CGFloat(x)
            let y = -3 * sin(floatX * radianPerPt + speed * radianPerPt) + (1 - CGFloat(progress)) * rect.height
            let point = CGPoint(x: floatX, y: y)
            if x == 0 {
                wavePath.move(to: point)
            } else {
                wavePath.addLine(to: point)
            }
        }
        wavePath.addLine(to: CGPoint(x: rect.width, y: rect.height))
        wavePath.addLine(to: CGPoint(x: 0, y: rect.height))
        wavePath.close()
        ctx?.addPath(wavePath.cgPath)
        ctx?.setFillColor(UIColor.green.withAlphaComponent(1).cgColor)
        ctx?.fillPath()
        
        let progressStr = NSString(string: String(format: "%.1f%%", progress * 100))
        let textSize = progressStr.sizeUseFont(14)
        let textLoc = CGPoint(x: (rect.width - textSize.width) * 0.5,
                              y: (rect.height - textSize.height) * 0.5)
   
        progressStr.draw(at: textLoc, withAttributes: [.foregroundColor: UIColor.orange,
                                                       .font: UIFont.systemFont(ofSize: 14)])
        
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width * 0.5
        clipsToBounds = true
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor.green.cgColor
        waveTimer = CADisplayLink(target: self, selector: #selector(redrawWave))
        waveTimer.add(to: .current, forMode: .common)
    }
    @objc func redrawWave() {
        setNeedsDisplay()
    }
        
    override func removeFromSuperview() {
        super.removeFromSuperview()
        waveTimer.invalidate()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}
