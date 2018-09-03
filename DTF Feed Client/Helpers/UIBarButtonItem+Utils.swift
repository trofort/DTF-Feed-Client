//
//  UIBarButtonItem+Utils.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 03.09.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {

    class func getBarButtonItemWithActivityIndivator() -> UIBarButtonItem {
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: .white)
        activityView.color = #colorLiteral(red: 0.08235294118, green: 0.4941176471, blue: 0.9843137255, alpha: 1)
        activityView.startAnimating()
        return UIBarButtonItem(customView: activityView)
    }

}
