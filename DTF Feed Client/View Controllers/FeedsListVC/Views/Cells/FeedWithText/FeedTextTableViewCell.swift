//
//  FeedTextTableViewCell.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 30.08.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import UIKit

class FeedTextTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var hostLabel: UILabel!
    
    // MARK: - Configure Method
    
    public func configure(with feed: Feed) {
        titleLabel.text = feed.title
        descLabel.text = feed.desc
        authorLabel.text = feed.author
        dateLabel.text = feed.date.stringDate
        hostLabel.text = feed.link?.host
    }
    

    // MARK: - Life cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        descLabel.text = nil
        authorLabel.text = nil
    }
}
