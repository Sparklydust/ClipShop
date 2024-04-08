//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class CategoryModelTests: XCTestCase {

  var sut: CategoryModel!

  override func setUp() async throws {
    try await super.setUp()
    sut = CategoryModel(with: .fake())
  }

  override func tearDown() async throws {
    sut = nil
    try await super.tearDown()
  }

  func testInitialization_id_isEqualToValueFromPassedDataObjectInInit() {
    let expected = CategoryData.fake().id

    let result = sut.id

    XCTAssertEqual(result, expected, "`id` value must be equal to `\(expected)` data object value from init parameter.")
  }

  func testInitialization_name_isEqualToValueFromPassedDataObjectInInit() throws {
    let expected = CategoryData.fake().name

    let result = sut.name

    XCTAssertEqual(result, expected, "`name` value must be equal to `\(expected)` data object value from init parameter.")
  }
}
