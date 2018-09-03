//
//  FeedsListVC.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 30.08.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import UIKit

class FeedsListVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var feedTableView: UITableView!
    
    // MARK: - Variables
    
    private lazy var presenter: FeedsListPresenter = {
        let presenter: FeedsListPresenter = FeedsListPresenter()
        presenter.delegate = self
        return presenter
    }()
    
    private lazy var adapter: FeedAdapter = {
        let adapter = FeedAdapter(with: feedTableView)
        adapter.delegate = self
        return adapter
    }()
    
    private var feedUrl: String {
        guard let channel = channel else {
            return ""
        }
        return "https://" + channel.host + "/" + channel.rssPath
    }
    
    var channel: Channel?
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        presenter.loadFeeds(with: feedUrl)
    }
    
    // MARK: - Methods
    
    private func configureView() {
        title = channel?.host
    }
}

//MARK: - ModelViewDelegate

extension FeedsListVC: FeedPresenterDelegate {
    
    func feedPresenter(_ presenter: FeedsListPresenter, didLoad feeds: [Feed]) {
        print("Feeds loaded")
        adapter.reloadData(with: feeds)
    }
    
}

extension FeedsListVC: FeedAdapterDelegate {
    
    func feedAdapter(_ feedAdapter: FeedAdapter, didSeledt feed: Feed) {
        print("Feed selected with name: ", feed.title)
        guard let nextVC = UIStoryboard.main.instantiateVC(FeedVC.self) else { return }
        nextVC.feed = feed
        pushVC(nextVC)
    }
    
}
