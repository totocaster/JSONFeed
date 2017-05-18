//
//  JSONFeedHub.swift
//  JSONFeed
//
//  Created by Toto Tvalavadze on 2017/05/18.
//  Copyright © 2017 Toto Tvalavadze. All rights reserved.
//

import Foundation

struct JSONFeedHub {
    let type: String
    let url: URL
    
    internal init?(json: JsonDictionary) {
        let keys = JSONFeedSpecV1Keys.Hub.self
        
        guard
            let url = URL(for: keys.url, inJson: json),
            let type = json[keys.type] as? String
            else { return nil }
        
        self.url = url
        self.type = type
    }
    
}
