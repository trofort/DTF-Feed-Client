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
    
    lazy var modelView: FeedViewModel = {
        let modelView: FeedViewModel = FeedViewModel()
        modelView.delegate = self
        return modelView
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
        print("loaded")
    }
    
    func feedViewModel(_ viewModel: FeedViewModel, didCautch error: String) {
        print(error)
    }
}
