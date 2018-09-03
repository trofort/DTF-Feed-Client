//
//  ChannelsTableViewAdapter.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 01.09.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import Foundation
import UIKit

protocol ChannelsTableViewAdapterDelegate {
    func channelsAdapter(_ channelsAdapter: ChannelsTableViewAdapter, didSelect channel: Channel)
}

class ChannelsTableViewAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Variables
    
    private var tableView: UITableView
    private var channels = [Channel]()
    
    var delegate: ChannelsTableViewAdapterDelegate?

    // MARK: - Initialize
    
    init(with tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Methods
    
    public func reloadData(with channels: [Channel]) {
        self.channels = channels
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = channels[indexPath.row].host
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.channelsAdapter(self, didSelect: channels[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            channels.remove(at: indexPath.row)
            CacheManager.default.channels.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}
