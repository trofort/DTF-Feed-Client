//
//  ApiManager.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 30.08.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import Foundation
import Alamofire
import AEXML
import PKHUD

class ApiManager {
    static let shared = ApiManager()
    
    func loadFeeds(with url: String, completion: @escaping (AEXMLDocument?) -> Void) {
        Alamofire.request(url,
                          method: .get,
                          parameters: nil,
                          encoding: URLEncoding.default,
                          headers: nil).response { (response) in
                            guard let xmlData = response.data else { return }
                            completion(try? AEXMLDocument(xml: xmlData))
        }
    }
    
    func loadAllFeeds(at channels: [Channel], completion: @escaping ([Feed]) -> Void) {
        let queue = DispatchQueue(label: "loadFeedsQueue")
        var feeds = [Feed]()
        channels.forEach({ channel in
            queue.async { [weak self] in
                let sema = DispatchSemaphore(value: 0)
                
                self?.loadFeeds(with: channel.fullPath, completion: { (xmlDoc) in
                    let items = xmlDoc?.root.children.first?.children.filter({ $0.name == "item" })
                    if items?.isEmpty ?? true {
                        UIAlertController.show(with: "Empty feeds")
                    } else {
                        items?.forEach({ feeds.append(Feed(with: $0)) })
                    }
                    sema.signal()
                })
                
                _ = sema.wait()
            }
        })
        queue.async {
            DispatchQueue.main.async {
                completion(feeds)
            }
        }
    }
    
}
