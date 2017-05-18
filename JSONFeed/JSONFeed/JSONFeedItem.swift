//
//  JSONFeedItem.swift
//  JSONFeed
//
//  Created by Toto Tvalavadze on 2017/05/18.
//  Copyright © 2017 Toto Tvalavadze. All rights reserved.
//

import Foundation

struct JSONFeedItem {
    let id: String
    let url: URL?
    let externalUrl: URL?
    let title: String?
    let contentText: String?
    let contentHtml: String?
    let summary: String?
    let image: URL?
    let bannerImage: URL?
    let date: Date
    let dateModified: Date?
    let author: JSONFeedAuhtor?
    let tags: [String] = []
    let attachments: [JSONFeedAttachment]
    
    internal init?(json: JsonDictionary) {
        let keys = JSONFeedSpecV1Keys.Item.self
        
        guard let id = json[keys.id] as? String else { return nil } // items without id will be discarded, per spec
        self.id = id
        
        self.url = URL(for: keys.url, inJson: json)
        self.externalUrl = URL(for: keys.externalUrl, inJson: json)
        self.title = json[keys.title] as? String
        self.contentText = json[keys.contentText] as? String
        self.contentHtml = json[keys.contentHtml] as? String
        self.summary = json[keys.summary] as? String
        self.image = URL(for: keys.image, inJson: json)
        self.bannerImage = URL(for: keys.bannerImage, inJson: json)
        
        if let dateString = json[keys.datePublished] as? String, let date = ISO8601DateFormatter().date(from: dateString) {
            self.date = date
        } else {
            self.date = Date() // per spec
        }

        if let dateModifiedString = json[keys.datePublished] as? String, let dateModified = ISO8601DateFormatter().date(from: dateModifiedString) {
            self.dateModified = dateModified
        } else {
            self.dateModified = nil
        }
        
        if let authorJson = json[keys.author] as? JsonDictionary {
            self.author = JSONFeedAuhtor(json: authorJson)
        } else {
            self.author = nil
        }
        
        if let attachmentsJson = json[keys.attachments] as? [JsonDictionary] {
            self.attachments = attachmentsJson.flatMap(JSONFeedAttachment.init)
        } else {
            self.attachments = []
        }
        
        
    }
    
}
