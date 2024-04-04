//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class CategoryDataTests: XCTestCase {

  var sut: CategoryData!

  override func setUp() async throws {
    try await super.setUp()
    sut = .fake()
  }

  override func tearDown() async throws {
    sut = .none
    try await super.tearDown()
  }

  func testInitialization_id_returnsAssociatedFakeValue() {
    let expected = CategoryData.fake().id

    let result = sut.id

    XCTAssertEqual(result, expected, "`id` must be equal to `\(expected)` when initialized with its fake value.")
  }

  func testInitialization_name_returnsAssociatedFakeValue() {
    let expected = CategoryData.fake().name

    let result = sut.name

    XCTAssertEqual(result, expected, "`name` must be equal to `\(expected)` when initialized with its fake value.")
  }
}
