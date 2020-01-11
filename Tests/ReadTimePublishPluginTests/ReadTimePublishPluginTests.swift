/**
* Read time plugin for Publish
* Copyright (C) Artur Rymarz 2020
* MIT license, see LICENSE file for details
*/

import XCTest
import ReadTimePublishPlugin
import Ink
import Publish
import Plot

final class ReadTimePublishPluginTests: XCTestCase {
    struct TestWebsite: Website {
        enum SectionID: String, WebsiteSectionID {
            case test
        }

        struct ItemMetadata: WebsiteItemMetadata {
        }

        var url = URL(string: "https://read-time.publish")!
        var name = "Read Time Publish"
        var description = "Publish plugin"
        var imagePath: Path? { nil }
        var language: Language { .english }
    }

    func testReadTime() {
        let parser = MarkdownParser()
        let html = parser.html(from: """
# Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id rutrum purus, et placerat magna. Donec condimentum eu risus et placerat. Donec consectetur eros non magna lobortis rutrum quis eget felis. Donec aliquam arcu et quam sagittis pulvinar. Nulla facilisi. Nulla faucibus tellus sit amet interdum vehicula. Mauris tincidunt elit at lectus tincidunt, in pretium sapien condimentum. Cras accumsan a nulla ac venenatis. Cras bibendum, orci at tincidunt eleifend, risus orci pellentesque ligula, a lacinia velit purus et velit. Morbi ligula risus, dapibus eget ante vel, porta finibus sapien.

## Aliquam magna orci, aliquet quis nulla ut, malesuada mollis neque. Phasellus tincidunt urna at eleifend faucibus. Cras metus mauris, tincidunt quis ante sit amet, lacinia placerat magna. Curabitur nisi mauris, facilisis nec ante eget, suscipit tincidunt nisl. Sed sagittis ante est. Ut non turpis vitae risus placerat fringilla. Curabitur nisl tellus, consectetur non risus id, condimentum hendrerit justo. Donec vulputate, massa nec sodales commodo, nibh leo imperdiet justo, a accumsan mauris lacus ac massa.

### Cras viverra iaculis volutpat. Nullam non sem felis. Curabitur ullamcorper sed nibh non vestibulum. Praesent quis mi vitae mauris pharetra tincidunt. Maecenas condimentum lacus sit amet lectus gravida pretium. Duis sed est rutrum, porttitor lectus non, commodo.
""")

        let content = Content(body: Content.Body(html: html))
        let item: Item<TestWebsite> = Item(path: "test", sectionID: .test, metadata: TestWebsite.ItemMetadata(), content: content)

        XCTAssertEqual(200, item.readTime().words)
        XCTAssertEqual(1, item.readTime().time)

        XCTAssertEqual(60, item.readTime(type: .seconds).time)
        XCTAssertEqual(120, item.readTime(type: .seconds, averageWordsPerMinute: 100).time)
        XCTAssertEqual(30, item.readTime(type: .seconds, averageWordsPerMinute: 400).time)
    }

    static var allTests = [
        ("testReadTime", testReadTime),
    ]
}
