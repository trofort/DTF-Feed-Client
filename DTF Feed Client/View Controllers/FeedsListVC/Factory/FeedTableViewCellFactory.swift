//
//  FeedTableViewCellFactory.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 30.08.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import Foundation
import UIKit

class FeedTableViewCellFactory {
    
    class func generateCell(for tableView: UITableView, at indexPath: IndexPath, with feed: Feed) -> UITableViewCell {
        switch feed.type {
        case .text:
            guard let cell: FeedTextTableViewCell = tableView.dequeueReusableCell(withType: FeedTextTableViewCell.self, and: indexPath) else { return UITableViewCell() }
            cell.configure(with: feed)
            return cell
        case .withImage:
            guard let cell: FeedWithImageTableViewCell = tableView.dequeueReusableCell(withType: FeedWithImageTableViewCell.self, and: indexPath) else { return UITableViewCell() }
            cell.configure(with: feed)
            return cell
        case .withMultiImage:
            guard let cell: FeedWithMultiImageTableViewCell = tableView.dequeueReusableCell(withType: FeedWithMultiImageTableViewCell.self, and: indexPath) else { return UITableViewCell() }
            cell.configure(with: feed)
            return cell
        }
    }
    
}
