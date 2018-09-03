//
//  ChannelsVC.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 01.09.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import UIKit

class ChannelsVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var channelsTableView: UITableView!
    
    // MARK: - Variables
    
    private lazy var adapter: ChannelsTableViewAdapter = {
       let adapter = ChannelsTableViewAdapter(with: channelsTableView)
        adapter.delegate = self
        return adapter
    }()
    
    private lazy var presenter: ChannelPresenter = {
       let presenter = ChannelPresenter()
        presenter.delegate = self
        return presenter
    }()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    // MARK: - Methods
    
    private func reloadData() {
        adapter.reloadData(with: CacheManager.default.channels)
    }
    
    // MARK: - Actions
    
    @IBAction func addButtonTapped(_ sender: Any) {
        presenter.addButtonTapped()
    }
}

//MARK: - ChannelsTableViewAdapterDelegate

extension ChannelsVC: ChannelsTableViewAdapterDelegate {
    
    func channelsAdapter(_ channelsAdapter: ChannelsTableViewAdapter, didSelect channel: Channel?) {
        guard let nextVC = UIStoryboard.main.instantiateVC(FeedsListVC.self) else { return }
        nextVC.channel = channel
        pushVC(nextVC)
    }
    
}

//MARK: - ChannelsPresenterDelegate

extension ChannelsVC: ChannelPresenterDelegate {
    func channelPresenterWillReloadData(_ presenter: ChannelPresenter) {
        reloadData()
    }
}
