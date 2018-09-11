//
//  AEXMLElement+Utils.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 11.09.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import Foundation
import AEXML

extension AEXMLElement {
    
    func rssPath(with host: URL) -> String? {
        guard let fixURLString = attributes["href"]?.replacingOccurrences(of: "\\?(.+)", with: "", options: .regularExpression, range: nil),
        let href = URL(string: fixURLString) else { return nil }
        if href.host != nil {
            return href.absoluteString
        } else {
            return host.appendingPathComponent(href.absoluteString).absoluteString
        }
    }
    
    func iconPath(with host: URL) -> String? {
        guard let iconURL = URL(string: attributes["href"] ?? "") else { return nil }
        if iconURL.host != nil {
            return iconURL.absoluteString
        } else {
            return host.appendingPathComponent(iconURL.absoluteString).absoluteString
        }
    }
}
