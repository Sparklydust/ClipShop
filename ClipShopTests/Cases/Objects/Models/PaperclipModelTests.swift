//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class PaperclipModelTests: XCTestCase {

  var sut: PaperclipModel!

  override func setUp() async throws {
    try await super.setUp()
    sut = PaperclipModel(with: .fake())
  }

  override func tearDown() async throws {
    sut = nil
    try await super.tearDown()
  }

  func testInitialization_id_isEqualToValueFromPassedDataObjectInInit() {
    let expected = PaperclipData.fake().id

    let result = sut.id

    XCTAssertEqual(result, expected, "`id` value must be equal to `\(expected)` data object value from init parameter.")
  }

  func testInitialization_title_isEqualToValueFromPassedDataObjectInInit() {
    let expected = PaperclipData.fake().title

    let result = sut.title

    XCTAssertEqual(result, expected, "`title` value must be equal to `\(expected)` data object value from init parameter.")
  }

  func testInitialization_price_isEqualToValueFromPassedDataObjectInInit() {
    let expected = PaperclipData.fake().price

    let result = sut.price

    XCTAssertEqual(result, expected, "`price` value must be equal to `\(expected)` data object value from init parameter.")
  }
}
