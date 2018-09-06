//
//  ImagePreviewVC.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 06.09.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import UIKit

@objc protocol ImagePreviewVCDelegate {
    @objc optional func imagePreviewVCDidDisappear(_ imagePreviewVC: ImagePreviewVC)
}

class ImagePreviewVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var previewImageView: UIImageView!
    @IBOutlet private weak var backgroundView: UIView!
    
    // MARK: - Variables
    
    var imagePreviewObject = ImagePreviewObject()
    var delegate: ImagePreviewVCDelegate?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateIn()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animateOut()
    }
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.imagePreviewVCDidDisappear?(self)
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Methods
    
    private func configureView() {
        previewImageView.frame = imagePreviewObject.frame
        previewImageView.image = imagePreviewObject.image
        backgroundView.alpha = 0.0
        view.isOpaque = false
    }
    
    private func animateIn() {
        let imageSize = imagePreviewObject.image.size
        UIView.animate(withDuration: 0.3,
                       animations: { [weak self] in
                        guard let weakSelf = self else { return }
                        weakSelf.previewImageView.frame.origin.x = 16.0
                        weakSelf.previewImageView.w = weakSelf.view.w - 32.0
                        weakSelf.previewImageView.h = weakSelf.view.w * (imageSize.height / imageSize.width)
                        weakSelf.previewImageView.frame.origin.y = weakSelf.view.center.y - (weakSelf.previewImageView.h / 2)
                        weakSelf.backgroundView.alpha = 1.0
        })
    }
    
    private func animateOut() {
        UIView.animate(withDuration: 0.3,
                       animations: { [weak self] in
                        guard let weakSelf = self else { return }
                        weakSelf.previewImageView.frame = weakSelf.imagePreviewObject.frame
                        weakSelf.backgroundView.alpha = 0.0
        }) { [weak self] (completed) in
            if completed {
                self?.dismiss(animated: false, completion: nil)
            }
        }
    }
}
