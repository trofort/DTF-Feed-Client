//
//  FeedWithImageTableViewCell.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 30.08.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class FeedWithImageTableViewCell: FeedTextTableViewCell {

    // MARK: - Outlets
   
    @IBOutlet private weak var feedImageView: UIImageView!
    
    // MARK: - Configure Method
    
    public override func configure(with feed: Feed) {
        super.configure(with: feed)
        guard let imageUrlStr = feed.images.first, let imageUrl = URL(string: imageUrlStr) else { return }
        feedImageView.af_setImage(withURL: imageUrl)
    }
    
    // MARK: - Life cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        feedImageView.image = nil
    }

}
