# JSONFeed

![Swift Version](https://img.shields.io/badge/swift-3.0-orange.svg?style=flat)
[![Platform](https://img.shields.io/cocoapods/p/JSONFeed.svg?style=flat)](http://cocoapods.org/pods/Typist)
[![Twitter](https://img.shields.io/badge/twitter-@totocaster-blue.svg)](http://twitter.com/totocaster)

Swift parser for JSON Feed — a new format similar to RSS and Atom but in JSON. For more information about this new feed format visit: https://jsonfeed.org


---

⚠️ **This is work in progress repo. Contributions are more than welcome! ** Here is how my todo list looks like now:

- [x] Implement framework so its usable
- [ ] Add much more elaborate tests
- [ ] Proper in-line documentation
- [x] Clear documentation in README (you are looking at it now)
- [x] Add CococaPods support
- [ ] Add Carthage support

Thanks for checking-out JSONFeed!

---

## Usage

Parsing feed is super easy, just pass data from responce or file to when crating feed object and that's it! 

```swift
let feed = try? JSONFeed(data: responceData)
```

Alternatively you can create objects from JSON string or JSON dictionary:

```swift
let dictionary:[String: Any] = ["title":"..."]
let feed = try? JSONFeed(json: dictionary)
```

```swift
let utf8String: String = "{'title':'..."
let feed = try? JSONFeed(jsonString: utf8String)
```

Parsing happens upon initialization using `JSONSerialization` and if all goes well you'll be able to access `feed` properties. In case initialization parameters are invalid `JSONFeed` will throw `JSONFeedError`.

---

## Documentation

Bets way to learn about this library is to browse source files and inline documentation. 

Below is quick description of objects and their responsibilities for those who are in hurry:

### Feed and Properties in General 

JSONFeed mirrors [JSON Feed v1 spec][v1] defined keys almost one-to-one. Key names are "Swiftyfied" are strongly typed: all dates will be `Date` type, URLs — `URL` and so on. All fields defined by optional in [specs][v1] are also Swift optionals in all objects.

### Items

`feed.items` is an array of `JSONFeedItem` objects that wrap your posts (or episodes for podcasts). It can not be nil, but can contain 0 elements.

##### `contextText` vs `contentHTML` 

According to specs both are optional and both can be present in post at the same time. However if none of them is set by publisher, post will be discarded and not included in `items` array.
 
##### Posts with no `id`

If `id` for the item is not set by published, item will be discarded and not included in `items`. This happens silently and error will be thrown. Any other posts with set `id` will be peresent in array. Reason for that in clearly elaborated in _Suggestions for Feed Readers_ of [JSON Feed v1 spec][v1]:

> [...] there is one thing we insist on: any item without an id must be discarded. We come to this from years of experience dealing with feeds in other formats where unique identifiers are optional. Without unique identifiers, it’s impossible to reliably refer to a given item and its changes over time, and this is terrible for user experience and becomes a source of bug reports to you. 


### Attachments

Items can have `attachments` wrapped in `JSONFeedAttachment` object. Attachment can be podcast episode, additional images, or any other media.

You can lear about attachment type using `mimeType` property. All attachments have `url` pointing to attached media.

Additionally `JSONFeedAttachment` have optional `size` (in bytes) and `duration` (in seconds) for relevant media files.

### Author

Inert `JSONFeedAuthor` struct with name, avatar URL and web URL. Can be present both in `JSONFeedItem` and/or in `JSONFeed`.


---

## Installation

Coming soon.


---

## License

Typist is released under the MIT license. See ``LICENSE`` for details.


[v1]: https://jsonfeed.org/version/1