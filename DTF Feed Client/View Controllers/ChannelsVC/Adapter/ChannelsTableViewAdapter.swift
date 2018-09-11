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
    func channelsAdapter(_ channelsAdapter: ChannelsTableViewAdapter, didSelect channel: Channel?)
}

class ChannelsTableViewAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    enum ChannelsSectionType: Int {
        case all = 0
        case hosts = 1
        
        var title: String? {
            switch self {
            case .all:      return nil
            case .hosts:    return "Channels"
            }
        }
        
        var height: CGFloat {
            switch self {
            case .all:      return 0.0
            case .hosts:    return 30.0
            }
        }
    }
    
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = ChannelsSectionType(rawValue: section)
        return sectionType == .all ? 1 : channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = ChannelsSectionType(rawValue: indexPath.section)
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = sectionType == .all ? "All News" : channels[indexPath.row].title
        if sectionType != .all, let iconPath = channels[indexPath.row].iconPath,
            let iconUrl = URL(string: iconPath) {
            cell.imageView?.contentMode = .scaleToFill
            cell.imageView?.af_setImage(withURL: iconUrl)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ChannelsSectionType(rawValue: section)?.title
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let sectionType = ChannelsSectionType(rawValue: indexPath.section)
        delegate?.channelsAdapter(self, didSelect: sectionType == .all ? nil : channels[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            channels.remove(at: indexPath.row)
            CacheManager.default.channels.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ChannelsSectionType(rawValue: section)?.height ?? 0.0
    }
}
