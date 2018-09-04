//
//  Channel.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 03.09.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import Foundation
import UIKit
import AEXML

class Channel: Codable {
    
    var host: String
    var rssPath: String

    init?(with host: URL, and data: Data) {
        self.host = host.host ?? ""
        guard let string = String(data: data, encoding: .utf8) ?? String(data: data, encoding: .ascii),
            let firstMatch = string.matchesForRegexInText("<link rel=\\\"alternate\\\" type=\\\"application\\/rss\\+xml\\\"[^>]*href=\\\"[^>]*\\\"[^>]*>").first else { return nil }
        let fixXML = firstMatch.replacingOccurrences(of: "/>", with: ">").replacingOccurrences(of: ">", with: "/>")
        guard let root = try? AEXMLDocument(xml: fixXML).root,
            let fixURLString = root.attributes["href"]?.replacingOccurrences(of: "\\?(.+)", with: "", options: .regularExpression, range: nil),
            let href = URL(string: fixURLString) else { return nil }
        if href.host != nil {
            rssPath = href.absoluteString
        } else {
            rssPath = host.appendingPathComponent(href.absoluteString).absoluteString
        }
    }
}
