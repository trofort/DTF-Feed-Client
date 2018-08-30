//
//  UITableView+Utils.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 30.08.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(T: T.Type) {
        let nib = UINib(nibName: "\(T.self)", bundle: nil)
        register(nib, forCellReuseIdentifier: "\(T.self)")
    }
    
    func dequeueReusableCell<T: UITableViewCell>(withType: T.Type, and indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: "\(T.self)", for: indexPath) as? T
    }
}
