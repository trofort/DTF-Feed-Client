//
//  FeedViewModel.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 30.08.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import Foundation
import UIKit

protocol FeedViewModelDelegate {
    func feedViewModel(_ viewModel: FeedViewModel, didLoad feeds: [Feed])
    func feedViewModel(_ viewModel: FeedViewModel, didCautch error: String)
}

class FeedViewModel {
    
    // MARK: - Variables
    
    var delegate: FeedViewModelDelegate?
    
    // MARK: - Public methods
    
    public func loadFeeds() {
        ApiManager.shared.loadFeeds { [weak self] (xmlDocument) in
            guard let weakSelf = self else { return }
            guard let xmlDoc = xmlDocument else {
                weakSelf.delegate?.feedViewModel(weakSelf, didCautch: "Feeds loaded with error")
                return
            }
            let items = xmlDoc.children.filter({ $0.name == "item" })
            if items.isEmpty {
                weakSelf.delegate?.feedViewModel(weakSelf, didCautch: "Empty feeds")
            } else {
                var feeds = [Feed]()
                items.forEach({ feeds.append(Feed(with: $0)) })
                weakSelf.delegate?.feedViewModel(weakSelf, didLoad: feeds)
            }
        }
    }
    
}
