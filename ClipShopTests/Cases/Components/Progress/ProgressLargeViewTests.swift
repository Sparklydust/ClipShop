//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class ProgressLargeViewTests: XCTestCase {

  var sut:  ProgressLargeView!

  override func setUp() async throws {
    try await super.setUp()
    sut = await ProgressLargeView(frame: .zero)
  }

  override func tearDown() async throws {
    sut = nil
    try await super.tearDown()
  }

  func testInitialization_contentMode_isEqualToScaleAspectFill() {
    let expected: UIActivityIndicatorView.Style = .large

    let result = sut.style

    XCTAssertEqual(result, expected, "`style` must be equal to `\(expected)` when initialized.")
  }

  func testInitialization_color_isEqualToAccent() {
    let expected: UIColor = .accent

    let result = sut.color

    XCTAssertEqual(result, expected, "`color` must be equal to `\(expected)` when initialized.")
  }
}
