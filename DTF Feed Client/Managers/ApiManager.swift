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

class ApiManager {
    static let shared = ApiManager()
    
    private let feedURL = "https://dtf.ru/feed"
    
    func loadFeeds(completion: @escaping (AEXMLDocument?) -> Void) {
        Alamofire.request(feedURL,
                          method: .get,
                          parameters: nil,
                          encoding: URLEncoding.default,
                          headers: nil).response { (response) in
                            guard let xmlData = response.data else { return }
                            completion(try? AEXMLDocument(xml: xmlData))
        }
    }
    
}
