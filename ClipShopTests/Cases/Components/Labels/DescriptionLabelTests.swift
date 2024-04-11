//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class DescriptionLabelTests: XCTestCase {

  var sut: DescriptionLabel!

  override func setUp() async throws {
    try await super.setUp()
    sut = await DescriptionLabel(frame: .zero)
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

  func testInitialization_font_isEqualToBody() {
    let expected: UIFont = .preferredFont(forTextStyle: .body)

    let result = sut.font

    XCTAssertEqual(result, expected, "`font` must be equal to `\(expected)` when initialized.")
  }

  func testInitialization_numberOfLines_isEqualToZero() {
    let expected: Int = .zero

    let result = sut.numberOfLines

    XCTAssertEqual(result, expected, "`numberOfLines` must be equal to `\(expected)` when initialized.")
  }
}
