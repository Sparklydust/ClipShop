//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class ServerEndpointTests: XCTestCase {

  func testCase_paperClipListURL_isEqualToExpectedValue() throws {
    let expected = try XCTUnwrap(URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json"))

    let result = ServerEndpoint.paperclipsList.url

    XCTAssertEqual(result, expected, "Endpoint URL for `paperclipsList` case must be equal to `\(expected)`.")
  }
}
