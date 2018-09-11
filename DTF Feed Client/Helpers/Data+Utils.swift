//
//  Data+Utils.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 11.09.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import Foundation

extension Data {
    
    func convertToString(with encodings: [String.Encoding]) -> String? {
        for index in 0..<encodings.count {
            if let string = String(data: self, encoding: encodings[index]) {
                return string
            }
        }
        return nil
    }
}
