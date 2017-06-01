//
//  JSONFeedItem.swift
//  JSONFeed
//
//  Created by Toto Tvalavadze on 2017/05/18.
//  Copyright © 2017 Toto Tvalavadze. All rights reserved.
//

import Foundation

public struct JSONFeedItem {
    
    /// Unique for that item for that feed over time. If an item is ever updated, the id should be unchanged.
    public let id: String
    
    /// URL of the resource described by the item. It’s the permalink. This may be the same as the `id`.
    public let url: URL?
    
    ///  URL of a page elsewhere. This is especially useful for linkblogs. If `url` links to where you’re talking about a thing, then `externalUrl` links to the thing you’re talking about.
    public let externalUrl: URL?
    
    /// Plain text title of item. Microblog items in particular may omit titles.
    public let title: String?
    
    /// This is the plain text of the item. A Twitter-like service might use it.
    public let contentText: String?
    
    /// A Twitter-like service might use `contentText`, while a blog might use `contentHtml`. Use whichever makes sense for your resource.
    public let contentHtml: String?
    
    /// lain text sentence or two describing the item. This might be presented in a timeline, for instance, where a detail view would display all of `contentHtml` or `contentText`.
    public let summary: String?
    
    /// URL of the main image for the item.
    public let image: URL?
    
    /// URL of an image to use as a banner. Some blogging systems (such as Medium) display a different banner image chosen to go with each post, but that image wouldn’t otherwise appear in the `contentHtml`.
    public let bannerImage: URL?
    
    /// Date item was published.`contentHtml`
    /// - warning: If formating was wrong from publisher's side, date of parsing is set.
    public let date: Date
    
    /// Specifies the modification date.Date
    /// - warning: If formating was wrong from publisher's side, date of parsing is set.
    public let dateModified: Date?
    
    /// Specifies the feed author. The author object has several members, see `JSONFeedAuthor`.
    public let author: JSONFeedAuthor?
    
    /// Tags tend to be just one word, but they may be anything.
    /// - note: they are not the equivalent of Twitter hashtags. Some blogging systems and other feed formats call these categories.
    public let tags: [String] = []
    
    // Lists related resources. Podcasts, for instance, would include an attachment that’s an audio or video file. See `JSONFeedAttachment`.
    public let attachments: [JSONFeedAttachment]
    
    
    // MARK: - Parsing
    
    internal init?(json: JsonDictionary) {
        let keys = JSONFeedSpecV1Keys.Item.self
        
        guard let id = json[keys.id] as? String else { return nil } // items without id will be discarded, per spec
        self.id = id
        
        let contentText = json[keys.contentText] as? String
        let contentHtml = json[keys.contentHtml] as? String
        
        if contentHtml == nil && contentText == nil {
            return nil
        } else {
            self.contentHtml = contentHtml
            self.contentText = contentText
        }
        
        self.url = URL(for: keys.url, inJson: json)
        self.externalUrl = URL(for: keys.externalUrl, inJson: json)
        self.title = json[keys.title] as? String
        self.summary = json[keys.summary] as? String
        self.image = URL(for: keys.image, inJson: json)
        self.bannerImage = URL(for: keys.bannerImage, inJson: json)
        
        if let dateString = json[keys.datePublished] as? String, let date = ISO8601DateFormatter().date(from: dateString) {
            self.date = date
        } else {
            self.date = Date() // per spec
        }

        if let dateModifiedString = json[keys.dateModified] as? String, let dateModified = ISO8601DateFormatter().date(from: dateModifiedString) {
            self.dateModified = dateModified
        } else {
            self.dateModified = nil
        }
        
        if let authorJson = json[keys.author] as? JsonDictionary {
            self.author = JSONFeedAuthor(json: authorJson)
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
