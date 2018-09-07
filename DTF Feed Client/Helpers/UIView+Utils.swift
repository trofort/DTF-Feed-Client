//
//  UIView+Utils.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 07.09.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func moveToCenter(of view: UIView) {
        let center = CGPoint(x: view.center.x - (w / 2),
                             y: view.center.y - (h / 2))
        frame.origin = center
    }
    
    func scale(by scale: CGFloat) {
        let newWidth = w * scale
        let newHeight = h * scale
        frame.origin.y = y + ((h / 2) - (newHeight / 2))
        frame.origin.x = x + ((w / 2) - (newWidth / 2))
        frame.size.width = newWidth
        frame.size.height = newHeight
    }
}
