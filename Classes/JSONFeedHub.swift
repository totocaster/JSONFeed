//
//  JSONFeedHub.swift
//  JSONFeed
//
//  Created by Toto Tvalavadze on 2017/05/18.
//  Copyright © 2017 Toto Tvalavadze. All rights reserved.
//

import Foundation

public struct JSONFeedHub {
    public let type: String
    public let url: URL
    
    // MARK: - Parsing
    
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
