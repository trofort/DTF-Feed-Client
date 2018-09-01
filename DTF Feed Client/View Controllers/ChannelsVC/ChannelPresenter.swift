//
//  ChannelPresenter.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 01.09.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import Foundation
import UIKit

protocol ChannelPresenterDelegate {
    func channelPresenterWillReloadData(_ presenter: ChannelPresenter)
}

class ChannelPresenter {
    
    // MARK: - Variables
    
    var delegate: ChannelPresenterDelegate?
    
    // MARK: - Public methods
    
    public func addButtonTapped() {
        UIAlertController.show(with: "Add new URL",
                               message: "Please, type host") { [weak self] (newChannel) in
                                if let newChannel = newChannel {
                                    guard let weakSelf = self else { return }
                                    CacheManager.default.channels.append(newChannel)
                                    weakSelf.delegate?.channelPresenterWillReloadData(weakSelf)
                                } else {
                                    UIAlertController.show(with: "Error", message: "Please, type host name")
                                }
        }
    }
    
}
