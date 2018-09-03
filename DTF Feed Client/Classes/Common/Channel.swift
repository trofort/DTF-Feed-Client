//
//  Channel.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 03.09.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import Foundation
import UIKit

class Channel: Codable {
    
    var host: String
    var rssPath: String
    
    init(with host: String, rssPath: String) {
        self.host = host
        self.rssPath = rssPath
    }
}
