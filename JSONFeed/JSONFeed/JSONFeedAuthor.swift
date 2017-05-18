//
//  JSONFeedAuthor.swift
//  JSONFeed
//
//  Created by Toto Tvalavadze on 2017/05/18.
//  Copyright © 2017 Toto Tvalavadze. All rights reserved.
//

import Foundation

struct JSONFeedAuhtor {
    let name: String?
    let url: URL?
    let avatar: URL?
    
    internal init(json: JsonDictionary) {
        let keys = JSONFeedSpecV1Keys.Author.self
        
        self.name = json[keys.name] as? String
        self.url = URL(for: keys.url, inJson: json)
        self.avatar = URL(for: keys.avatar, inJson: json)

    }
}
