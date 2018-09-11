//
//  ChannelTableViewCellFactory.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 11.09.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import Foundation
import UIKit

class ChannelTableViewCellFactory {
    
    class func cell(for channel: Channel?, indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        if let channel = channel {
            guard let cell = tableView.dequeueReusableCell(withType: ChannelTableViewCell.self, and: indexPath) else { return UITableViewCell() }
            cell.configure(with: channel)
            return cell
        } else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "All News"
            return cell
        }
    }
    
}
