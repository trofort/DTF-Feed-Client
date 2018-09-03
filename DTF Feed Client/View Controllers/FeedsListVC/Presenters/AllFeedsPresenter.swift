//
//  AllFeedsPresenter.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 03.09.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import Foundation
import UIKit
import PKHUD

class AllFeedsPresenter: FeedsListPresenter {

    // MARK: - Methods
    
    override func loadFeeds(with url: String) {
        HUD.show(.progress)
        let channels = CacheManager.default.channels
        ApiManager.shared.loadAllFeeds(at: channels) { [weak self] feeds in
            guard let weakSelf = self else { return }
            let sortFeeds = feeds.sorted(by: { $0.date > $1.date })
            weakSelf.delegate?.feedPresenter(weakSelf, didLoad: sortFeeds)
            DispatchQueue.main.async {
                HUD.hide()
            }
        }
    }
    
}
