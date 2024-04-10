//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class PriceLargeLabelTests: XCTestCase {

  var sut: PriceLargeLabel!

  override func setUp() async throws {
    try await super.setUp()
    sut = await PriceLargeLabel(frame: .zero)
  }

  override func tearDown() async throws {
    sut = nil
    try await super.tearDown()
  }

  func testInitialization_textAlignment_isLeft() {
    let expected: NSTextAlignment = .left

    let result = sut.textAlignment

    XCTAssertEqual(result, expected, "`textAlignment` must be equal to `\(expected)` when initialized.")
  }

  func testInitialization_font_isEqualToTitle3ForRegularElseHeadline() {
    let expected = UIDevice.current.userInterfaceIdiom == .pad
    ? UIFont.preferredFont(forTextStyle: .title3)
    : .preferredFont(forTextStyle: .headline)

    let result = sut.font

    XCTAssertEqual(result, expected, "`font` must be equal to `\(expected)` when initialized.")
  }
}
