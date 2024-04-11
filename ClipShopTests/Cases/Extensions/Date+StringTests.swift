//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class Date_StringTests: XCTestCase {

  func testExtension_WithVariousDates_returnsExpectedFullDateString() {
    let dateFake = Date(timeIntervalSince1970: .zero)
    let expected = "jeudi 1 janvier 1970"

    let result = dateFake.toString()

    // Assert: Verify the result matches the expected output
    XCTAssertEqual(result, expected, "The `toString()` method must be equal to `\(expected)` for the given date.")
  }
}
