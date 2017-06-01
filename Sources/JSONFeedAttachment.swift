//
//  JSONFeedAttachment.swift
//  JSONFeed
//
//  Created by Toto Tvalavadze on 2017/05/18.
//  Copyright © 2017 Toto Tvalavadze. All rights reserved.
//

import Foundation

public struct JSONFeedAttachment {
    
    /// Specifies the location of the attachment.
    public let url: URL
    
    /// Specifies the type of the attachment, such as `audio/mpeg`.
    public let mimeType: String
    
    /// name for the attachment. 
    /// - important: if there are multiple attachments, and two or more have the exact same title (when title is present), then they are considered as alternate representations of the same thing. In this way a podcaster, for instance, might provide an audio recording in different formats.
    public let title: String?
    
    /// Specifies how large the file is in *bytes*.
    public let size: UInt64?
    
    /// Specifies how long the attachment takes to listen to or watch in *seconds*.
    public let duration: UInt?
    
    
    // MARK: - Parsing
    
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
