//
//  JSONFeedAuthor.swift
//  JSONFeed
//
//  Created by Toto Tvalavadze on 2017/05/18.
//  Copyright © 2017 Toto Tvalavadze. All rights reserved.
//

import Foundation

public struct JSONFeedAuhtor {
    
    /// The author’s name
    public let name: String?
    
    /// URL of a site owned by the author. It could be a blog, micro-blog, Twitter account, and so on.
    public let url: URL?
    
    /// URL for an image for the author. As with `icon`, it should be square and relatively large.
    public let avatar: URL?
    
    
    // MARK: - Parsing
    
    internal init(json: JsonDictionary) {
        let keys = JSONFeedSpecV1Keys.Author.self
        
        self.name = json[keys.name] as? String
        self.url = URL(for: keys.url, inJson: json)
        self.avatar = URL(for: keys.avatar, inJson: json)

    }
}
