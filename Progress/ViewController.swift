//
//  ViewController.swift
//  Progress
//
//  Created by 周伟克 on 2020/7/2.
//  Copyright © 2020 周伟克. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var progressView: ProgressView!
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        progressView = ProgressView(frame: CGRect(origin: .zero,
                                                  size: CGSize(width: 100, height: 100)))
        progressView.center = view.center
        view.addSubview(progressView)
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        timer = Timer(timeInterval: 1 / 60.0, repeats: true, block: { (timer) in
            let step = Double(arc4random_uniform(5)) * 0.001
            self.progressView.progress += step
            if self.progressView.progress == 1 {
                timer.invalidate()
            }
        })
        timer.fire()
        RunLoop.current.add(timer, forMode: .common)
    }
    
}

