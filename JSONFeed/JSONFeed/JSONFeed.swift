//
//  JSONFeed.swift
//  JSONFeed
//
//  Created by Toto Tvalavadze on 2017/05/18.
//  Copyright © 2017 Toto Tvalavadze. All rights reserved.
//

import Foundation

public typealias JsonDictionary = [String: Any]

public enum JSONFeedError: Error {
    case invalidFeed
    case invalidJson
}

class JSONFeed {
    
    let version: URL
    let title: String
    let homePage: URL?
    let url: URL?
    let feedDescription: String?
    let comment: String?
    let nextFeed: URL?
    let icon: URL?
    let favicon: URL?
    let author: JSONFeedAuhtor?
    let isExpired: Bool
    let hubs: [JSONFeedHub]
    
    let items: [JSONFeedItem]
    
    init(json: JsonDictionary) throws {
        let keys = JSONFeedSpecV1Keys.Top.self // easier on eyes
        
        guard
            let version = URL(for: keys.version, inJson: json),
            let title = json[keys.title] as? String
            else {
                throw JSONFeedError.invalidFeed
            }
        
        self.version = version
        self.title = title

        self.homePage = URL(for: keys.homePageUrl, inJson: json)
        self.url = URL(for: keys.feedUrl, inJson: json)
        self.feedDescription = json[keys.description] as? String
        self.comment = json[keys.userComment] as? String
        self.nextFeed = URL(for: keys.nextUrl, inJson: json)
        self.icon = URL(for: keys.icon, inJson: json)
        self.favicon = URL(for: keys.favicon, inJson: json)
        self.isExpired = json[keys.expired] as? Bool ?? false // nil = false, as per spec
        
        if let authorJson = json[keys.author] as? JsonDictionary {
            self.author = JSONFeedAuhtor(json: authorJson)
        } else {
            self.author = nil
        }
        
        if let hubs = json[keys.hubs] as? [JsonDictionary] {
            self.hubs = [] // TODO: ..
        } else {
            self.hubs = []
        }
        
        if let itemsJson = json[keys.items] as? [JsonDictionary] {
            self.items = itemsJson.flatMap(JSONFeedItem.init)
        } else {
            self.items = []
        }
        
    }
    
    convenience init(data: Data) throws {
        guard let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? JsonDictionary else { throw JSONFeedError.invalidJson }
        try self.init(json: jsonDict)
    }
    
    convenience init(jsonString: String) throws {
        let data = jsonString.data(using: .utf8)!
        try self.init(data: data)
    }
}


extension URL {
    init?(for key: String, inJson json: JsonDictionary) {
        guard let urlString = json[key] as? String else { return nil }
        self.init(string: urlString)
    }
}
