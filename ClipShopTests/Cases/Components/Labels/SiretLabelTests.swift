//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class SiretLabelTests: XCTestCase {

  var sut: SiretLabel!

  override func setUp() async throws {
    try await super.setUp()
    sut = await SiretLabel(frame: .zero)
  }

  override func tearDown() async throws {
    sut = nil
    try await super.tearDown()
  }

  func testInitialization_font_isEqualCaption1() {
    let expected: UIFont = .preferredFont(forTextStyle: .caption1)

    let result = sut.font

    XCTAssertEqual(result, expected, "`font` must be equal to `\(expected)` when initialized.")
  }

  func testInitialization_numberOfLines_isEqualToZero() {
    let expected: Int = 1

    let result = sut.numberOfLines

    XCTAssertEqual(result, expected, "`numberOfLines` must be equal to `\(expected)` when initialized.")
  }
}
