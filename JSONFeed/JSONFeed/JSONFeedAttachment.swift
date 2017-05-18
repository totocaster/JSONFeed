//
//  JSONFeedAttachment.swift
//  JSONFeed
//
//  Created by Toto Tvalavadze on 2017/05/18.
//  Copyright © 2017 Toto Tvalavadze. All rights reserved.
//

import Foundation

struct JSONFeedAttachment {
    let url: URL
    let mimeType: String
    let title: String?
    let size: UInt64? // bytes
    let duration: UInt? // seconds
    
    internal init?(json: JsonDictionary) {
        let keys = JSONFeedSpecV1Keys.Attachment.self
        
        guard
            let url = URL(for: keys.url, inJson: json),
            let mimeType = json[keys.mimeType] as? String
            else { return nil } // items without id will be discarded, per spec
        
        self.url = url
        self.mimeType = mimeType
        
        self.title = json[keys.title] as? String
        self.duration = json[keys.durationSeconds] as? UInt
        self.size = json[keys.sizeBytes] as? UInt64
        
    }

}
