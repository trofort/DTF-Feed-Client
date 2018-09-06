//
//  ImagePreviewObject.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 06.09.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import Foundation
import UIKit

class ImagePreviewObject {
    var image: UIImage
    var frame: CGRect
    
    init() {
        self.image = UIImage()
        self.frame = .zero
    }
    
    init(image: UIImage?, frame: CGRect?) {
        self.image = image ?? UIImage()
        self.frame = frame ?? .zero
    }
}
