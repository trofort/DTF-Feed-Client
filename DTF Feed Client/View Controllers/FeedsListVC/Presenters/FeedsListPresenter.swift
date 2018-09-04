//
//  FeedViewModel.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 30.08.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import Foundation
import UIKit
import PKHUD

protocol FeedPresenterDelegate {
    func feedPresenter(_ presenter: FeedsListPresenter, didLoad feeds: [Feed])
}

class FeedsListPresenter {
    
    // MARK: - Variables
    
    var delegate: FeedPresenterDelegate?
    
    // MARK: - Public methods
    
    public func loadFeeds(with url: String) {
        HUD.show(.labeledProgress(title: "Loading news", subtitle: "Please, wait"))
        ApiManager.shared.loadFeeds(with: url) { [weak self] (xmlDocument) in
            DispatchQueue.main.async {
                HUD.hide()
            }
            guard let weakSelf = self else { return }
            guard let xmlDoc = xmlDocument else {
                UIAlertController.show(with: "Feeds loaded with error")
                return
            }
            let items = xmlDoc.root.children.first?.children.filter({ $0.name == "item" })
            if items?.isEmpty ?? true {
                UIAlertController.show(with: "Empty feeds")
            } else {
                var feeds = [Feed]()
                items?.forEach({ feeds.append(Feed(with: $0)) })
                weakSelf.delegate?.feedPresenter(weakSelf, didLoad: feeds)
            }
            
        }
    }
    
}
