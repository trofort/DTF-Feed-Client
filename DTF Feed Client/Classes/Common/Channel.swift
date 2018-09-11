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
    var title: String
    var iconPath: String?

    init(host: String, rssPath: String, title: String, iconPath: String?) {
        self.host = host
        self.rssPath = rssPath
        self.title = title
        self.iconPath = iconPath
    }
    
    class func generateChannels(from host: URL, and data: Data) -> [Channel] {
        var channels = [Channel]()
        guard let xmlMetaData = AEXMLDocument(channelData: data) else { return channels }
        xmlMetaData.root["rss"].children.forEach { (rssElement) in
            guard let rssPath = rssElement.rssPath(with: host), let channelHost = host.host else { return }
            let title = rssElement.attributes["title"] ?? channelHost
            let iconPath = xmlMetaData.root["icon"]["link"].iconPath(with: host)
            channels.append(Channel(host: channelHost, rssPath: rssPath, title: title, iconPath: iconPath))
        }
        return channels
    }
}
