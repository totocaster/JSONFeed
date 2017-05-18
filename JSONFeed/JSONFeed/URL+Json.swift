//
//  URL+Json.swift
//  JSONFeed
//
//  Created by Toto Tvalavadze on 2017/05/18.
//  Copyright © 2017 Toto Tvalavadze. All rights reserved.
//

import Foundation

// I'm not super happy with this, more elegant solution would be nicer.
extension URL {
    init?(for key: String, inJson json: JsonDictionary) {
        guard let urlString = json[key] as? String else { return nil }
        self.init(string: urlString)
    }
}
