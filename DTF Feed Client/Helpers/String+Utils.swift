//
//  String+Utils.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 11.09.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import Foundation
import AEXML

public let rssTagRegex = "<[^>]*link[^>]*(rel[^>]*=[^>]*\\\"alternate\\\"|type[^>]*=[^>]*\\\"application\\/rss\\+xml\\\")[^>]*(rel[^>]*=[^>]*\\\"alternate\\\"|type[^>]*=[^>]*\\\"application\\/rss\\+xml\\\")[^>]*href[^>]*=[^>]*\\\"[^>]*\\\"[^>]*>"
public let iconTagRegex = "<[^>]*link[^>]*rel[^>]*=[^>]*\\\"shortcut icon\\\"[^>]*href[^>]*=[^>]*\\\"[^>]*\\\"[^>]*>"

extension String {
    
    func findHTMLTag(with regex: String) -> [AEXMLElement] {
        var elements = [AEXMLElement]()
        let matches = self.matchesForRegexInText(regex)
        matches.forEach { (match) in
            let fixXML = match.replacingOccurrences(of: "/>", with: ">").replacingOccurrences(of: ">", with: "/>")
            guard let element = try? AEXMLDocument(xml: fixXML).root else { return }
            elements.append(element)
        }
        return elements
    }
    
}
