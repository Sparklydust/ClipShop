//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class ServerEndpointTests: XCTestCase {

  func testCase_paperclipListURL_isEqualToExpectedValue() throws {
    let expected = try XCTUnwrap(URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json"))

    let result = ServerEndpoint.paperclipsList.url

    XCTAssertEqual(result, expected, "Endpoint URL for `paperclipsList` case must be equal to `\(expected)`.")
  }

  func testCase_paperClipCategories_isEqualToExpectedValue() throws {
    let expected = try XCTUnwrap(URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json"))

    let result = ServerEndpoint.paperclipCategories.url

    XCTAssertEqual(result, expected, "Endpoint URL for `paperclipCategories` case must be equal to `\(expected)`.")
  }
}
