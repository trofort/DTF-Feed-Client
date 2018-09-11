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
        resetPosition(withResizing: true)
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
        configureGesture()
    }
    
    private func configureGesture() {
        var startWidth = previewImageView.frame.width
        previewImageView.addPinchGesture { [weak self] (pinch) in
            guard let view = pinch.view else { return }
            if pinch.state == .began {
                startWidth = view.frame.width
            }
            if pinch.state == .ended && view.w < (view.superview?.w ?? 0.0) - 32.0 {
                self?.resetPosition(withResizing: false)
            }
            view.scale(by: startWidth * pinch.scale / view.w)
        }
        
        var startPos = previewImageView.frame.origin
        previewImageView.addPanGesture { [weak self] (pan) in
            guard let view = pan.view else { return }
            if pan.state == .began {
                startPos = view.frame.origin
            }
            let newPoint = pan.translation(in: view.superview)
            self?.calculatePreviewPos(with: CGPoint(x: startPos.x + newPoint.x, y: startPos.y + newPoint.y))
        }
        
        previewImageView.addTapGesture(tapNumber: 2) { (tap) in
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.2, animations: { [weak self] in
                    guard let view = tap.view else { return }
                    if view.w < UIScreen.main.bounds.w {
                        view.scale(by: 3.0)
                    } else {
                        self?.resetPosition(withResizing: true)
                    }
                })
            }
        }
        
        backgroundView.addTapGesture { [weak self] (tap) in
            self?.animateOut()
        }
        
        var startPosY = previewImageView.frame.origin.y
        backgroundView.addPanGesture { [weak self] (pan) in
            guard let weakSelf = self else { return }
            if pan.state == .began {
                startPosY = weakSelf.previewImageView.frame.origin.y
            }
            let yTranslation = pan.translation(in: weakSelf.view).y
            if yTranslation < 0 {
                self?.backgroundView.alpha = 1 + (yTranslation / 100.0)
                weakSelf.previewImageView.frame.origin.y = startPosY + yTranslation
            }
            if pan.state == .ended {
                if  yTranslation < -100 {
                    self?.animateOut()
                } else {
                    self?.resetPosition(withResizing: true)
                }
            }
        }
    }
    
    // MARK: - Help methods
    
    private func calculatePreviewPos(with newPoint: CGPoint) {
        let frame = previewImageView.frame
        let screenSize = UIScreen.main.bounds
        if (newPoint.x <= 16.0 && frame.x < newPoint.x) || (newPoint.x + frame.w >= screenSize.w - 16.0 && frame.x > newPoint.x) {
            previewImageView.frame.origin.x = newPoint.x
        }
        if (newPoint.y <= 32.0 && frame.y < newPoint.y) || (newPoint.y + frame.h >= screenSize.h - 32.0 && frame.y > newPoint.y)  {
            previewImageView.frame.origin.y = newPoint.y
        }
    }
    
    // MARK: - Animation
    
    private func resetPosition(withResizing resize: Bool) {
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: 0.3,
                           animations: { [weak self] in
                            guard let weakSelf = self else { return }
                            if resize {
                                weakSelf.previewImageView.frame.size = weakSelf.imagePreviewObject.image.size
                                let scale = (weakSelf.view.w - 32.0) / weakSelf.previewImageView.w
                                weakSelf.previewImageView.scale(by: scale)
                            }
                            weakSelf.previewImageView.moveToCenter(of: weakSelf.view)
                            weakSelf.backgroundView.alpha = 1.0
            })
        }
    }
    
    private func animateOut() {
        DispatchQueue.main.async { [weak self] in
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
}
