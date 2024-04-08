//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class UrgentSmallIconTests: XCTestCase {

  var sut: UrgentSmallIcon!

  override func setUp() async throws {
    try await super.setUp()
    sut = await UrgentSmallIcon(frame: .zero)
  }

  override func tearDown() async throws {
    sut = nil
    try await super.tearDown()
  }

  func testInitialization_contentMode_isEqualToScaleAspectFit() {
    let expected: UIView.ContentMode = .scaleAspectFit

    let result = sut.contentMode

    XCTAssertEqual(result, expected, "`contentMode` must be equal to `\(expected)` when initialized.")
  }

  func testInitialization_layerTintColor_isEqualToAccent() {
    let expected: UIColor = .accent

    let result = sut.tintColor

    XCTAssertEqual(result, expected, "`layer.tintColor` must be equal to `\(expected)` when initialized.")
  }
}
