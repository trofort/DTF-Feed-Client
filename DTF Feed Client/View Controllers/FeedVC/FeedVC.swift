//
//  FeedVC.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 03.09.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import UIKit
import WebKit
import PKHUD

class FeedVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var webView: WKWebView!
    
    // MARK: - Variables
    
    var feed: Feed?
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - Methods
    
    private func configureView() {
        title = feed?.title
        
        guard let url = feed?.link else { return }
        webView.navigationDelegate = self
        webView.load(URLRequest(url: url))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.getBarButtonItemWithActivityIndivator()
    }
}

//MARK: - WKNavigationDelegate

extension FeedVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        navigationItem.rightBarButtonItem = nil
    }
    
}
