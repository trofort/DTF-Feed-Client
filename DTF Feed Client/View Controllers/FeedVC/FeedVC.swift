//
//  FeedVC.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 03.09.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import UIKit
import WebKit

class FeedVC: UIViewController {
    
    @IBOutlet private weak var webView: WKWebView!
    
    var link: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.
        webView.reload()
    }
}
