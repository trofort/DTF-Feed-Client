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
        HUD.show(.progress)
        Alamofire.request(url,
                          method: .get,
                          parameters: nil,
                          encoding: URLEncoding.default,
                          headers: nil).response { (response) in
                            guard let xmlData = response.data else { return }
                            completion(try? AEXMLDocument(xml: xmlData))
                            PKHUD.sharedHUD.hide()
        }
    }
    
}
