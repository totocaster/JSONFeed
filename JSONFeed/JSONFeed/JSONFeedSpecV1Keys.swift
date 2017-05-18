//
//  JSONFeedSpecV1Keys.swift
//  JSONFeed
//
//  Created by Toto Tvalavadze on 2017/05/18.
//  Copyright © 2017 Toto Tvalavadze. All rights reserved.
//

import Foundation

internal enum JSONFeedSpecV1Keys {
    enum Top {
        static let version = "version"
        static let title = "title"
        static let homePageUrl = "home_page_url"
        static let feedUrl = "feed_url"
        static let description = "description"
        static let userComment = "user_comment"
        static let nextUrl = "next_url"
        static let icon = "icon"
        static let favicon = "favicon"
        static let author = "author"
        static let expired = "expired"
        static let hubs = "hubs"
        static let items = "items"
    }
    
    enum Author {
        static let name = "name"
        static let url = "url"
        static let avatar = "avatar"
    }
    
    enum Item {
        static let id = "id"
        static let url = "url"
        static let externalUrl = "external_url"
        static let title = "title"
        static let contentHtml = "content_html"
        static let contentText = "content_text"
        static let summary = "summary"
        static let image = "image"
        static let bannerImage = "banner_image"
        static let datePublished = "date_published"
        static let dateModified = "date_modified"
        static let author = "author"
        static let tags = "tags"
        static let attachments = "attachments"
    }
    
    enum Attachment {
        static let url = "url"
        static let mimeType = "mime_type"
        static let title = "title"
        static let sizeBytes = "size_in_bytes"
        static let durationSeconds = "duration_in_seconds"
    }
}
