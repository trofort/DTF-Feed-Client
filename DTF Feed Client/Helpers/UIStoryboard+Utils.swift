//
//  UIStoryboard+Utils.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 01.09.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    class var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    // MARK: - Help method
    
    func instatiate<T: UIViewController>(_ type: T.Type) -> T? {
        return instantiateViewController(withIdentifier: "\(T.self)") as? T
    }
    
}
