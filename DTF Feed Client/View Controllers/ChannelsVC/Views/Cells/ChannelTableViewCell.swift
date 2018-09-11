//
//  ChannelTableViewCell.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 11.09.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import Foundation
import UIKit

class ChannelTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
    }
    
    public func configure(with channel: Channel) {
        titleLabel.text = channel.title
        if let iconPath = channel.iconPath, let iconUrl = URL(string: iconPath) {
            iconImageView.af_setImage(withURL: iconUrl)
        }
    }
}

