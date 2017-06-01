//
//  JSONFeed+Equatable.swift
//  JSONFeed
//
//  Created by Toto Tvalavadze on 2017/05/21.
//  Copyright © 2017 Toto Tvalavadze. All rights reserved.
//

import Foundation

extension JSONFeedItem: Equatable {
    public static func ==(_ lhs: JSONFeedItem, _ rhs: JSONFeedItem) -> Bool {
        return lhs.id == rhs.id
            && lhs.attachments == rhs.attachments
            && lhs.author == rhs.author
            && lhs.bannerImage == rhs.bannerImage
            && lhs.contentHtml == rhs.contentHtml
            && lhs.contentText == rhs.contentText
            && lhs.date == rhs.date
            && lhs.dateModified == rhs.dateModified
            && lhs.externalUrl == rhs.externalUrl
            && lhs.image == rhs.image
            && lhs.summary == rhs.summary
            && lhs.tags == rhs.tags
            && lhs.title == rhs.title
            && lhs.url == rhs.url
    }
}

extension JSONFeedAttachment: Equatable {
    public static func ==(_ lhs: JSONFeedAttachment, _ rhs: JSONFeedAttachment) -> Bool {
        return lhs.url == rhs.url
            && lhs.mimeType == rhs.mimeType
            && lhs.duration == rhs.duration
            && lhs.size == rhs.size
            && lhs.title == rhs.title
    }
}

extension JSONFeedAuthor: Equatable {
    public static func ==(_ lhs: JSONFeedAuthor, _ rhs: JSONFeedAuthor) -> Bool {
        return lhs.name == rhs.name
            && lhs.avatar == rhs.avatar
            && lhs.url == rhs.url
    }
}
