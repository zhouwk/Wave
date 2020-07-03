//
//  ViewController.swift
//  DoubleWave
//
//  Created by 周伟克 on 2020/7/2.
//  Copyright © 2020 周伟克. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let waveView = WaveView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 200))
        waveView.center.y = view.center.y
        view.addSubview(waveView)

    }


}

