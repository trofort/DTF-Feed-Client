//
//  AEXMLDocument+Utils.swift
//  DTF Feed Client
//
//  Created by Максим Деханов on 10.09.2018.
//  Copyright © 2018 Максим Деханов. All rights reserved.
//

import Foundation
import AEXML

extension AEXMLDocument {
    
    convenience init?(channelData data: Data) {
        guard let string = data.convertToString(with: [.utf8, .ascii]) else { return nil }
        self.init(root: AEXMLElement(name: "Channel"))
        
        let rssChildren = string.findHTMLTag(with: rssTagRegex)
        root.addChild(AEXMLElement(name: "rss"))
        root["rss"].addChildren(rssChildren)
        
        if let icon = string.findHTMLTag(with: iconTagRegex).first {
            root.addChild(AEXMLElement(name: "icon"))
            root["icon"].addChild(icon)
        }
    }
    
}
