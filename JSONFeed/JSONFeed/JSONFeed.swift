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
    let isExpired: Bool = false
    let hubs: [JSONFeedHub] = []
    
    let items: [JSONFeedItem] = []
    
    init(json: JsonDictionary) throws {
        let topKey = JSONFeedSpecV1Keys.Top.self // easier on eyes
        
        guard
            let version = json[topKey.version] as? URL,
            let title = json[topKey.title] as? String
            else {
                throw JSONFeedError.invalidFeed
            }
        
        self.version = version
        self.title = title
        
        if let homePage = json[topKey.homePageUrl] as? URL {
            self.homePage = homePage
        }
        
        if let url = json[topKey.feedUrl] as? URL {
            self.url = url
        }
        
        if let feedDescription = json[topKey.description] as? String {
            self.feedDescription = feedDescription
        }
        
        if let comment = json[topKey.userComment] as? String {
            self.comment = comment
        }
        
        if let nextFeed = json[topKey.nextUrl] as? URL {
            self.nextFeed = nextFeed
        }
        
        if let icon = json[topKey.icon] as? URL {
            self.icon = icon
        }
        
        if let favicon = json[topKey.favicon] as? URL {
            self.favicon = favicon
        }
        
        if let author = json[topKey.author] as? JsonDictionary {
            self.author = nil // TODO: ...
        }
        
        if let isExpired = json[topKey.expired] as? Bool {
            self.isExpired = isExpired
        }
        
        if let hubs = json[topKey.hubs] as? [JsonDictionary] {
            self.hubs = [] // TODO: ..
        }
        
        if let jsonItems = json[topKey.items] as? [JsonDictionary] {
            var result:[JSONFeedItem] = []
            for jsonItem in jsonItems {
                if let item = JSONFeedItem(json: jsonItem) {
                    result.append(item)
                }
            }
            self.items = result
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



struct JSONFeedAuhtor {
    let name: String?
    let url: URL?
    let avatar: URL?
}

struct JSONFeedHub {
    let type: String
    let url: String
}
