//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class HStackViewTests: XCTestCase {

  var sut:  HStackView!

  override func setUp() async throws {
    try await super.setUp()
    sut = await HStackView()
  }

  override func tearDown() async throws {
    sut = nil
    try await super.tearDown()
  }

  func testInitialization_backgroundColor_isEqualToSystemGray4() {
    let expected: UIColor = .clear

    let result = sut.backgroundColor

    XCTAssertEqual(result, expected, "`backgroundColor` must be equal to `\(expected)` when initialized.")
  }

  func testInitialization_axis_isEqualHorizontal() {
    let expected: NSLayoutConstraint.Axis = .horizontal

    let result = sut.axis

    XCTAssertEqual(result, expected, "`axis` must be equal to `\(expected)` when initialized.")
  }
}
