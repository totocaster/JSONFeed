//
//  JSONFeed.swift
//  JSONFeed
//
//  Created by Toto Tvalavadze on 2017/05/18.
//  Copyright © 2017 Toto Tvalavadze. All rights reserved.
//

import Foundation

/// Same as `[String: Any]`
public typealias JsonDictionary = [String: Any]


public enum JSONFeedError: Error {

    /// Data is not recognized as valid feed.
    case invalidFeed
    
    /// Data is not recognized as valid JSON.
    case invalidJson
}


/// Feed represenration and parsing object.
public class JSONFeed {
    
    /// URL of the version of the format the feed uses.
    public let version: URL
    
    /// Name of the feed, which will often correspond to the name of the website (blog, for instance), though not necessarily.
    public let title: String
    
    /// URL of the resource that the feed describes. This resource may or may not actually be a “home” page, but it should be an HTML page.
    public let homePage: URL?
    
    // URL of the feed, and serves as the unique identifier for the feed. As with `homePage`, this should be considered required for feeds on the public web.
    public let url: URL?
    
    /// Provides more detail, beyond the `title`, on what the feed is about. A feed reader may display this text.
    public let feedDescription: String?
    
    /// Description of the purpose of the feed. This is for the use of people looking at the raw parsed JSON, and should be ignored by feed readers.
    public let comment: String?
    
    /// URL of a feed that provides the next n items, where n is determined by the publisher. This allows for pagination, but with the expectation that reader software is not required to use it and probably won’t use it very often. 
    public let nextFeed: URL?
    
    /// URL of an image for the feed suitable to be used in a timeline, much the way an avatar might be used. It should be square and relatively large — such as 512 x 512 — so that it can be scaled-down and so that it can look good on retina displays.
    public let icon: URL?
    
    /// URL of an image for the feed suitable to be used in a source list. It should be square and relatively small, but not smaller than 64 x 64 (so that it can look good on retina displays).
    public let favicon: URL?
    
    /// Specifies the feed author. The author object has several members, see `JSONFeedAuthor`.
    public let author: JSONFeedAuthor?
    
    /// says whether or not the feed is finished — that is, whether or not it will ever update again.
    public let isExpired: Bool
    
    /// Describes endpoints that can be used to subscribe to real-time notifications from the publisher of this feed.
    public let hubs: [JSONFeedHub]
    
    /// Items of this feed.
    public let items: [JSONFeedItem]
    
    
    // MARK: - Parsing
    
    public init(json: JsonDictionary) throws {
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
            self.author = JSONFeedAuthor(json: authorJson)
        } else {
            self.author = nil
        }
        
        if let hubsJson = json[keys.hubs] as? [JsonDictionary] {
            self.hubs = hubsJson.flatMap(JSONFeedHub.init)
        } else {
            self.hubs = []
        }
        
        if let itemsJson = json[keys.items] as? [JsonDictionary] {
            self.items = itemsJson.flatMap(JSONFeedItem.init)
        } else {
            self.items = []
        }
        
    }
    
    public convenience init(data: Data) throws {
        guard let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? JsonDictionary else { throw JSONFeedError.invalidJson }
        try self.init(json: jsonDict)
    }
    
    public convenience init(jsonString: String) throws {
        let data = jsonString.data(using: .utf8)!
        try self.init(data: data)
    }
}
