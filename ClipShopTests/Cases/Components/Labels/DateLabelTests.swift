//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class DateLabelTests: XCTestCase {

  var sut: DateLabel!

  override func setUp() async throws {
    try await super.setUp()
    sut = await DateLabel(frame: .zero)
  }

  override func tearDown() async throws {
    sut = nil
    try await super.tearDown()
  }

  func testInitialization_font_isEqualToCalloutForRegularElseFootnote() {
    let expected: UIFont = UIDevice.current.userInterfaceIdiom == .pad
    ? .preferredFont(forTextStyle: .callout)
    : .preferredFont(forTextStyle: .footnote)

    let result = sut.font

    XCTAssertEqual(result, expected, "`font` must be equal to `\(expected)` when initialized.")
  }
}
