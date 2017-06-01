//
//  JSONFeedTests.swift
//  JSONFeedTests
//
//  Created by Toto Tvalavadze on 2017/05/18.
//  Copyright © 2017 Toto Tvalavadze. All rights reserved.
//

import XCTest
@testable import JSONFeed

class JSONFeedTests: XCTestCase {
    
    var jsonfeedOrg: Data! = nil
    var jsonfeedOrgPodcast: Data! = nil
    var jsonfeedOrgMicroblog: Data! = nil
    
    override func setUp() {
        super.setUp()
        
        let bundle = Bundle(for: type(of: self))
        
        jsonfeedOrg = NSData(contentsOfFile: bundle.path(forResource: "jsonfeed_org", ofType: "json")!)! as Data
        jsonfeedOrgPodcast = NSData(contentsOfFile: bundle.path(forResource: "jsonfeed_org_podcast", ofType: "json")!)! as Data
        jsonfeedOrgMicroblog = NSData(contentsOfFile: bundle.path(forResource: "jsonfeed_org_microblog", ofType: "json")!)! as Data
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParseJsonFeedOrg() {
        let feed = try! JSONFeed(data: jsonfeedOrg)
        
        XCTAssert(feed.title == "My Example Feed")
        XCTAssert(feed.homePage == URL(string: "https://example.org/"))
        XCTAssert(feed.items.count == 2)
        
        let first = feed.items.first!
        XCTAssert(first.contentText == "This is a second item.")
        XCTAssert(first.url == URL(string: "https://example.org/second-item"))
        XCTAssert(first.id == "2")
        
    }
    
    func testParseJsonFeedOrgPodcast() {
        let feed = try! JSONFeed(data: jsonfeedOrgPodcast)
        
        XCTAssert(feed.items.count == 1)
        
        let first = feed.items.first!
        XCTAssert(first.contentHtml == "Chris has worked at <a href=\"http://adobe.com/\">Adobe</a> and as a founder of Rogue Sheep, which won an Apple Design Award for Postage. Chris’s new company is Aged & Distilled with Guy English — which shipped <a href=\"http://aged-and-distilled.com/napkin/\">Napkin</a>, a Mac app for visual collaboration. Chris is also the co-host of The Record. He lives on <a href=\"http://www.ci.bainbridge-isl.wa.us/\">Bainbridge Island</a>, a quick ferry ride from Seattle.")
        XCTAssert(first.url == URL(string: "http://therecord.co/chris-parrish"))
        XCTAssert(first.id == "http://therecord.co/chris-parrish")
        XCTAssert(first.attachments.count == 1)
        
        let attach = first.attachments.first!
        XCTAssert(attach.mimeType == "audio/x-m4a")
        XCTAssert(attach.url == URL(string: "http://therecord.co/downloads/The-Record-sp1e1-ChrisParrish.m4a"))
        XCTAssert(attach.size == 89970236)
        XCTAssert(attach.duration == 6629)
        
    }
    
    func testParseJsonFeedOrgMicroblog() {
        let feed = try! JSONFeed(data: jsonfeedOrgMicroblog)
        
        XCTAssertNotNil(feed.author, "Microblog sample has author")
        
        let author = feed.author!
        XCTAssert(author.name == "Brent Simmons")
        XCTAssert(author.url == URL(string: "http://example.org/"))
        XCTAssert(author.avatar == URL(string: "https://example.org/avatar.png"))
        
        
    }
}
