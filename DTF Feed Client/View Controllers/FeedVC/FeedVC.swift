//
//  FeedVC.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 30.08.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var feedTableView: UITableView!
    
    // MARK: - Variables
    
    private lazy var presenter: FeedPresenter = {
        let presenter: FeedPresenter = FeedPresenter()
        presenter.delegate = self
        return presenter
    }()
    
    private lazy var adapter: FeedAdapter = {
        let adapter = FeedAdapter(with: feedTableView)
        adapter.delegate = self
        return adapter
    }()
    
    var feedUrl: String = ""
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.loadFeeds(with: feedUrl)
    }
    // MARK: - Methods
    
    private func configureView() {
        title = "Feeds"
    }
}

//MARK: - ModelViewDelegate

extension FeedVC: FeedPresenterDelegate {
    
    func feedPresenter(_ presenter: FeedPresenter, didLoad feeds: [Feed]) {
        print("Feeds loaded")
        adapter.reloadData(with: feeds)
    }
    
}

extension FeedVC: FeedAdapterDelegate {
    
    func feedAdapter(_ feedAdapter: FeedAdapter, didSeledt feed: Feed) {
        print("Feed selected with name: ", feed.title)
        guard let feedUrl = feed.link else { return }
        if UIApplication.shared.canOpenURL(feedUrl) {
            UIApplication.shared.open(feedUrl, options: [:], completionHandler: nil)
        }
    }
    
}
