//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class DividerViewTests: XCTestCase {

  var sut:  DividerView!

  override func setUp() async throws {
    try await super.setUp()
    sut = await DividerView()
  }

  override func tearDown() async throws {
    sut = nil
    try await super.tearDown()
  }

  func testInitialization_backgroundColor_isEqualToSystemGray2() {
    let expected: UIColor = .systemGray2

    let result = sut.backgroundColor

    XCTAssertEqual(result, expected, "`backgroundColor` must be equal to `\(expected)` when initialized.")
  }
}
