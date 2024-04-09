//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

@available(iOS 15.0, *)
final class String_DateTests: XCTestCase {

  func testExtension_iso8601DateToUpdateStringToDate_returnsISO8601ToDate() throws {
    let dateFake = "2023-07-18T09:38:34Z"
    let expected = try XCTUnwrap(Date(dateFake, strategy: .iso8601))

    let result = dateFake.iso8601Date()

    XCTAssertEqual(result, expected, "String extension `iso8601Date()` must update `\(dateFake)` to `\(expected)`")
  }
}
