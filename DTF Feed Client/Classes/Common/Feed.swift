//
//  Feed.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 30.08.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import Foundation
import UIKit
import AEXML

public enum FeedType {
    case text
    case withImage
    case withMultiImage
}

class Feed {
    
    // MARK: - Properties
    
    var type: FeedType
    var title: String
    var author: String
    var desc: String
    var images = [String]()
    var link: URL?
    
    // MARK: - Initialize
    
    init(with xmlElement: AEXMLElement) {
        title = xmlElement["title"].string
        author = xmlElement["author"].string
        desc = xmlElement["description"].string.replacingOccurrences(of: "<[^>]+>", with: " ", options: .regularExpression, range: nil).trimmingCharacters(in: .whitespacesAndNewlines)
        link = URL(string: xmlElement["link"].string.replacingOccurrences(of: "?from-rss", with: ""))
        let imageLinks = xmlElement.children.filter({ $0.name == "enclosure" && $0.attributes["type"] == "image/jpeg" })
        if imageLinks.isEmpty {
            type = .text
        } else {
            if imageLinks.count == 1 {
                type = .withImage
            } else {
                type = .withMultiImage
            }
            imageLinks.forEach({
                guard let url = $0.attributes["url"] else { return }
                images.append(url)
            })
        }
    }
    
}
