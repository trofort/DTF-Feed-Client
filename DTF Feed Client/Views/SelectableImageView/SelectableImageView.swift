//
//  SelectableImageView.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 06.09.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import Foundation
import UIKit

class SelectableImageView: UIImageView {
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        configure()
    }
    
    override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    // MARK: - Methods
    
    private func configure() {
        addTapGesture { [weak self] (tap) in
            guard let topView = UIApplication.topViewController()?.view,
                let weakSelf = self else { return }
            let window = UIApplication.shared.keyWindow
            let frame =  weakSelf.convert(weakSelf.frame, from: topView)
            weakSelf.showPreview(imagePreviewObject: ImagePreviewObject(image: weakSelf.image, frame: frame))
        }
    }
    
    private func showPreview(imagePreviewObject: ImagePreviewObject) {
        guard let previewVC = UIStoryboard.main.instantiateVC(ImagePreviewVC.self) else { return }
        previewVC.imagePreviewObject = imagePreviewObject
        previewVC.modalPresentationStyle = .overCurrentContext
        previewVC.modalTransitionStyle = .crossDissolve
        UIApplication.topViewController()?.presentVC(previewVC)
    }
    
}
