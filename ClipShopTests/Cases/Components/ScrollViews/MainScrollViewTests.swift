//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class MainScrollViewTests: XCTestCase {

  var sut:  MainScrollView!

  override func setUp() async throws {
    try await super.setUp()
    sut = await MainScrollView()
  }

  override func tearDown() async throws {
    sut = nil
    try await super.tearDown()
  }

  func testInitialization_backgroundColor_isEqualToClear() {
    let expected: UIColor = .clear

    let result = sut.backgroundColor

    XCTAssertEqual(result, expected, "`backgroundColor` must be equal to `\(expected)` when initialized.")
  }
}
