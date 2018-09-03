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
    
    var channels: [Channel] {
        get { return get(key: kChannels, type: [Channel].self) ?? [Channel]() }
        set { set(key: kChannels, obj: newValue) }
    }
    
    // MARK: - Helpers
    
    private func get<T: Codable>(key: String, type: T.Type) -> T? {
        if let data = ud.data(forKey: key) {
            return try? JSONDecoder().decode(T.self, from: data)
        } else {
            return nil
        }
    }
    
    private func set<T: Codable>(key: String, obj: T?) {
        if let obj = obj {
            ud.set(try? JSONEncoder().encode(obj), forKey: key)
        } else {
            ud.removeObject(forKey: key)
        }
        ud.synchronize()
    }
    
}
