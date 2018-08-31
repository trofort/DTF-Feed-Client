//
//  FeedViewModel.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 30.08.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import Foundation
import UIKit

protocol FeedPresenterDelegate {
    func feedPresenter(_ presenter: FeedPresenter, didLoad feeds: [Feed])
    func feedPresenter(_ presenter: FeedPresenter, didCautch error: String)
}

class FeedPresenter {
    
    // MARK: - Variables
    
    var delegate: FeedPresenterDelegate?
    
    // MARK: - Public methods
    
    public func loadFeeds() {
        ApiManager.shared.loadFeeds { [weak self] (xmlDocument) in
            guard let weakSelf = self else { return }
            guard let xmlDoc = xmlDocument else {
                weakSelf.delegate?.feedPresenter(weakSelf, didCautch: "Feeds loaded with error")
                return
            }
            let items = xmlDoc.root.children.first?.children.filter({ $0.name == "item" })
            if items?.isEmpty ?? true {
                weakSelf.delegate?.feedPresenter(weakSelf, didCautch: "Empty feeds")
            } else {
                var feeds = [Feed]()
                items?.forEach({ feeds.append(Feed(with: $0)) })
                weakSelf.delegate?.feedPresenter(weakSelf, didLoad: feeds)
            }
        }
    }
    
}
