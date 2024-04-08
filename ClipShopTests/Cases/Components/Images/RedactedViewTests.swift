//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class RedactedViewTests: XCTestCase {

  var sut: RedactedView!

  override func setUp() async throws {
    try await super.setUp()
    sut = await RedactedView(frame: .zero)
  }

  override func tearDown() async throws {
    sut = nil
    try await super.tearDown()
  }

  func testInitialization_backgroundColor_isEqualToSystemGray4() {
    let expected: UIColor = .systemGray4

    let result = sut.backgroundColor

    XCTAssertEqual(result, expected, "`backgroundColor` must be equal to `\(expected)` when initialized.")
  }

  func testInitialization_layerCornerRadius_isEqualTo8() {
    let expected: CGFloat = 8

    let result = sut.layer.cornerRadius

    XCTAssertEqual(result, expected, "`layer.cornerRadius` must be equal to `\(expected)` when initialized.")
  }
}
