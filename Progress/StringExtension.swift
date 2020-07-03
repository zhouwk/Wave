//
//  StringExtension.swift
//  Progress
//
//  Created by 周伟克 on 2020/7/2.
//  Copyright © 2020 周伟克. All rights reserved.
//

import Foundation
import UIKit

extension NSString {
    
    
    func sizeUseFont(_ font: CGFloat) -> CGSize {
        let size = boundingRect(with: CGSize(width: CGFloat.infinity,
                                             height: CGFloat.infinity),
                                options: .usesLineFragmentOrigin,
                                attributes: [.font: UIFont.systemFont(ofSize: font)],
                                context: nil).size
        return CGSize(width: ceil(size.width), height: ceil(size.height))
    }
}
