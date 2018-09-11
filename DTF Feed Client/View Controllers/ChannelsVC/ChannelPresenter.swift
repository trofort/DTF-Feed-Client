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
                               message: "Please, type host") { (host) in
                                if let host = host {
                                    ApiManager.shared.loadPage(with: "http://" + host,
                                                               completion: { [weak self] (url, data) in
                                                                guard let channelData = data,
                                                                    let channelUrl = url else {
                                                                        UIAlertController.show(with: "Error", message: "Please, check your internet connection")
                                                                        return
                                                                }
                                                                
                                                                let newChannels = Channel.generateChannels(from: channelUrl, and: channelData)
                                                                guard let weakSelf = self, !newChannels.isEmpty else {
                                                                        UIAlertController.show(with: "Error", message: "Host without rss channel")
                                                                        return
                                                                }
                                                                CacheManager.default.channels.append(contentsOf: newChannels)
                                                                weakSelf.delegate?.channelPresenterWillReloadData(weakSelf)
                                    })
                                } else {
                                    UIAlertController.show(with: "Error", message: "Please, type host name")
                                }
        }
    }
    
}
