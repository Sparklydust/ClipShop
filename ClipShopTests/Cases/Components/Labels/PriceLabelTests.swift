//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class PriceLabelTests: XCTestCase {

  var sut: PriceLabel!

  override func setUp() async throws {
    try await super.setUp()
    sut = await PriceLabel(size: .small)
  }

  override func tearDown() async throws {
    sut = nil
    try await super.tearDown()
  }

  func testInitialization_textAlignment_isLeft() {
    let expected: NSTextAlignment = .left

    let result = sut.textAlignment

    XCTAssertEqual(result, expected, "`textAlignment` must be equal to `\(expected)` when initialized.")
  }

  func testInitialization_fontForSmallLabel_isEqualToHeadlineForRegularElseSubheadlineWeightMedium() {
    sut = PriceLabel(size: .small)
    let expected: UIFont = UIDevice.current.userInterfaceIdiom == .pad
    ? .preferredFont(forTextStyle: .headline)
    : .preferredFont(forTextStyle: .subheadline, weight: .medium)

    let result = sut.font

    XCTAssertEqual(result, expected, "`font` must be equal to `\(expected)` when initialized.")
  }

  func testInitialization_fontForLargeLabel_isEqualToTitle2WeightSemiboldForRegularElseHeadlineWeightSemibold() {
    sut = PriceLabel(size: .large)
    let expected: UIFont = UIDevice.current.userInterfaceIdiom == .pad
    ? .preferredFont(forTextStyle: .title2, weight: .semibold)
    : .preferredFont(forTextStyle: .headline, weight: .semibold)

    let result = sut.font

    XCTAssertEqual(result, expected, "`font` must be equal to `\(expected)` when initialized.")
  }
}
