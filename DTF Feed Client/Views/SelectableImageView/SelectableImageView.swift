//
//  SelectableImageView.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 06.09.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import Foundation
import UIKit

class SelectableImageView: UIImageView, ImagePreviewVCDelegate {
    
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
            weakSelf.alpha = 0.0
            var frame =  weakSelf.superview?.convert(weakSelf.frame, to: nil)
            weakSelf.showPreview(imagePreviewObject: ImagePreviewObject(image: weakSelf.image, frame: frame))
        }
    }
    
    private func showPreview(imagePreviewObject: ImagePreviewObject) {
        guard let previewVC = UIStoryboard.main.instantiateVC(ImagePreviewVC.self) else { return }
        previewVC.imagePreviewObject = imagePreviewObject
        previewVC.modalPresentationStyle = .overCurrentContext
        previewVC.delegate = self
        UIApplication.topViewController()?.present(previewVC, animated: false, completion: nil)
    }
    
    // MARK: - ImagePreviewVCDelegate
    
    func imagePreviewVCDidDisappear(_ imagePreviewVC: ImagePreviewVC) {
        alpha = 1.0
    }
    
}
