//
//  FeedWithMultiImageTableViewCell.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 30.08.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import UIKit

class FeedWithMultiImageTableViewCell: FeedTextTableViewCell {

    // MARK: - Outlets
    
    @IBOutlet private weak var imagesStackView: UIStackView!
    
    // MARK: - Public methods
    
    override func configure(with feed: Feed) {
        super.configure(with: feed)
        feed.images.forEach({
            if imagesStackView.arrangedSubviews.count == 3 {
                return
            }
            let imageView = UIImageView(frame: .zero)
            if let imageUrl = URL(string: $0) {
                imageView.clipsToBounds = true
                imageView.af_setImage(withURL: imageUrl)
                imageView.contentMode = .scaleAspectFill
                imagesStackView.addArrangedSubview(imageView)
            }
        })
    }
    
    // MARK: - Life cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        imagesStackView.arrangedSubviews.forEach({ imagesStackView.removeArrangedSubview($0) })
    }
}
