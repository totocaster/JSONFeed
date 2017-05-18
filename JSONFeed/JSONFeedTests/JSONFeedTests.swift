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
        let feed = try? JSONFeed(data: jsonfeedOrg)
        print("Error = \(feed)")
    
    }
    
    func testParseJsonFeedOrgPodcast() {
        let feed = try? JSONFeed(data: jsonfeedOrgPodcast)
        print("Error = \(feed)")
        
    }
    
    func testParseJsonFeedOrgMicroblog() {
        let feed = try? JSONFeed(data: jsonfeedOrgMicroblog)
        print("Error = \(feed)")
        
    }
    
    
    
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
