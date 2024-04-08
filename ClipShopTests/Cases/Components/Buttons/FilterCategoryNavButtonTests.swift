//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class FilterCategoryNavButtonTests: XCTestCase {

  var sut: FilterCategoryNavButton!

  override func setUp() async throws {
    try await super.setUp()
    sut = await FilterCategoryNavButton()
  }

  override func tearDown() async throws {
    sut = nil
    try await super.tearDown()
  }

  func testInitialization_categories_isEqualToEmptyArrayOfCategoryModel() {
    let expected = [CategoryModel]()

    let result = sut.categories

    XCTAssertEqual(result, expected, "`categories` must be equal to `\(expected)` when initialized.")
  }

  func testInitialization_selectedItem_isEqualToOptionalInt() {
    let expected: Int? = .none

    let result = sut.selectedItem

    XCTAssertEqual(result, expected, "`selectedItem` must be equal to `\(String(describing: expected))` when initialized.")
  }

  func testInitialization_tintColor_isEqualToAccent() {
    let expected: UIColor = .accent

    let result = sut.tintColor

    XCTAssertEqual(result, expected, "`layer.tintColor` must be equal to `\(expected)` when initialized.")
  }

  func testInitialization_image_isNotNil() {
    let result = sut.image

    XCTAssertNotNil(result, "SF Symbol `line.3.horizontal.decrease.circle` must be set as the button image.")
  }
}
