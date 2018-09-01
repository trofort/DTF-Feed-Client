//
//  CacheManager.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 01.09.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import Foundation

class CacheManager {
    
    static let `default` = CacheManager()
    
    // MARK: - ud
    
    private let ud = UserDefaults.standard
    
    // MARK: - Keys
    
    private let kChannels = "kChannels"
    
    // MARK: - Vatiables
    
    var channels: [String] {
        get { return ud.object(forKey: kChannels) as? [String] ?? [String]() }
        set { ud.set(newValue, forKey: kChannels) }
    }
    
}
