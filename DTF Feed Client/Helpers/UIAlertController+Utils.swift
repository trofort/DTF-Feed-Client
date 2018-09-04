//
//  UIAlertController+Utils.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 01.09.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import Foundation
import UIKit
import EZSwiftExtensions

extension UIAlertController {
    
    class func show(with title: String? = nil, message: String? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        DispatchQueue.main.async {
            UIApplication.topViewController()?.presentVC(alertController)
        }
    }
 
    class func show(with title: String? = nil, message: String? = nil, textFieldCompletion: @escaping (String?) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Host name"
            textField.keyboardType = .URL
        }
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            guard let firstTextField = alertController.textFields?[0] else { return }
            textFieldCompletion(firstTextField.text)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        DispatchQueue.main.async {
            UIApplication.topViewController()?.presentVC(alertController)
        }
    }
    
}
