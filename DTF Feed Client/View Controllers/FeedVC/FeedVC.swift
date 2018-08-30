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
    
    private lazy var modelView: FeedViewModel = {
        let modelView: FeedViewModel = FeedViewModel()
        modelView.delegate = self
        return modelView
    }()
    
    private lazy var adapter: FeedAdapter = {
        let adapter = FeedAdapter(with: feedTableView)
        adapter.delegate = self
        return adapter
    }()
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        modelView.loadFeeds()
    }
    // MARK: - Methods
    
    private func configureView() {
        title = "Feeds"
    }
}

//MARK: - ModelViewDelegate

extension FeedVC: FeedViewModelDelegate {
    
    func feedViewModel(_ viewModel: FeedViewModel, didLoad feeds: [Feed]) {
        print("Feeds loaded")
        adapter.reloadData(with: feeds)
    }
    
    func feedViewModel(_ viewModel: FeedViewModel, didCautch error: String) {
        print(error)
    }
}

extension FeedVC: FeedAdapterDelegate {
    
    func feedAdapter(_ feedAdapter: FeedAdapter, didSeledt feed: Feed) {
        print("Feed selected with name: \"%@\"", feed.title)
        guard let feedUrl = feed.link else { return }
        if UIApplication.shared.canOpenURL(feedUrl) {
            UIApplication.shared.open(feedUrl, options: [:], completionHandler: nil)
        }
    }
    
}
