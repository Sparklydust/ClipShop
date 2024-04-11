//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class CategorySmallLabelTests: XCTestCase {

  var sut: CategorySmallLabel!

  override func setUp() async throws {
    try await super.setUp()
    sut = await CategorySmallLabel(frame: .zero)
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

  func testInitialization_font_isEqualToFootnoteForRegularElseCaption1() {
    let expected = UIDevice.current.userInterfaceIdiom == .pad
    ? UIFont.preferredFont(forTextStyle: .footnote)
    : UIFont.preferredFont(forTextStyle: .caption1)

    let result = sut.font

    XCTAssertEqual(result, expected, "`font` must be equal to `\(expected)` when initialized.")
  }

  func testInitialization_textColor_isEqualToSecondaryLabel() {
    let expected: UIColor = .secondaryLabel

    let result = sut.textColor

    XCTAssertEqual(result, expected, "`textColor` must be equal to `\(expected)` when initialized.")
  }
}
