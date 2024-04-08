//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class TitleSmallLabelTests: XCTestCase {

  var sut: TitleSmallLabel!

  override func setUp() async throws {
    try await super.setUp()
    sut = await TitleSmallLabel(frame: .zero)
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

  func testInitialization_font_isEqualToTitle3WeightSemiboldForRegularElseCalloutWeightMedium() {
    let expected: UIFont = UIDevice.current.userInterfaceIdiom == .pad
    ? .preferredFont(forTextStyle: .title3, weight: .semibold)
    : .preferredFont(forTextStyle: .callout, weight: .medium)

    let result = sut.font

    XCTAssertEqual(result, expected, "`font` must be equal to `\(expected)` when initialized.")
  }

  func testInitialization_numberOfLines_isEqualTo3() {
    let expected: Int = 3

    let result = sut.numberOfLines

    XCTAssertEqual(result, expected, "`numberOfLines` must be equal to `\(expected)` when initialized.")
  }

  func testInitialization_allowsDefaultTighteningForTruncation_isEqualToTrue() {
    let result = sut.allowsDefaultTighteningForTruncation

    XCTAssertTrue(result, "`allowsDefaultTighteningForTruncation` must be true when initialized.")
  }
}
