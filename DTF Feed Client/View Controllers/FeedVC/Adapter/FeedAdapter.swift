//
//  FeedAdapter.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 30.08.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import Foundation
import UIKit

protocol FeedAdapterDelegate {
    func feedAdapter(_ feedAdapter: FeedAdapter, didSeledt feed: Feed)
}

class FeedAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Variables
    
    private var tableView: UITableView
    private var feeds = [Feed]()
    
    var delegate: FeedAdapterDelegate?
    
    // MARK: - Initialize
    
    init(with tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Public Methods
    
    public func reloadData(with feeds: [Feed]) {
        self.feeds = feeds
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if feeds.count > indexPath.row {
            delegate?.feedAdapter(self, didSeledt: feeds[indexPath.row])
        }
    }
}
