//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class TitleLargeLabelTests: XCTestCase {

  var sut: TitleLargeLabel!

  override func setUp() async throws {
    try await super.setUp()
    sut = await TitleLargeLabel(frame: .zero)
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

  func testInitialization_font_isEqualToLargeTitleForRegularElseTitle1() {
    let expected: UIFont = UIDevice.current.userInterfaceIdiom == .pad
    ? .preferredFont(forTextStyle: .largeTitle)
    : .preferredFont(forTextStyle: .title1)

    let result = sut.font

    XCTAssertEqual(result, expected, "`font` must be equal to `\(expected)` when initialized.")
  }

  func testInitialization_numberOfLines_isEqualToZero() {
    let expected: Int = .zero

    let result = sut.numberOfLines

    XCTAssertEqual(result, expected, "`numberOfLines` must be equal to `\(expected)` when initialized.")
  }
}
