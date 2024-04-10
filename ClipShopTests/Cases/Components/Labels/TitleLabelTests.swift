//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class TitleLabelTests: XCTestCase {

  var sut: TitleLabel!

  override func setUp() async throws {
    try await super.setUp()
    sut = await TitleLabel(size: .small)
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

  func testInitialization_fontForSmallSize_isEqualToTitle3WeightSemiboldForRegularElseCalloutWeightMedium() {
    sut = TitleLabel(size: .small)
    let expected: UIFont = UIDevice.current.userInterfaceIdiom == .pad
    ? .preferredFont(forTextStyle: .title3, weight: .semibold)
    : .preferredFont(forTextStyle: .callout, weight: .medium)

    let result = sut.font

    XCTAssertEqual(result, expected, "`font` must be equal to `\(expected)` when initialized.")
  }

  func testInitialization_fontForLargeSize_isEqualToLargeTitleForRegularElseTitle1() {
    sut = TitleLabel(size: .large)
    let expected: UIFont = UIDevice.current.userInterfaceIdiom == .pad
    ? .preferredFont(forTextStyle: .largeTitle)
    : .preferredFont(forTextStyle: .title1)

    let result = sut.font

    XCTAssertEqual(result, expected, "`font` must be equal to `\(expected)` when initialized.")
  }

  func testInitialization_numberOfLinesForSmallLabel_isEqualTo3() {
    sut = TitleLabel(size: .small)
    let expected: Int = 3

    let result = sut.numberOfLines

    XCTAssertEqual(result, expected, "`numberOfLines` must be equal to `\(expected)` when initialized.")
  }

  func testInitialization_numberOfLinesForLargeLabel_isEqualToZero() {
    sut = TitleLabel(size: .large)
    let expected: Int = .zero

    let result = sut.numberOfLines

    XCTAssertEqual(result, expected, "`numberOfLines` must be equal to `\(expected)` when initialized.")
  }

  func testInitialization_allowsDefaultTighteningForTruncation_isEqualToTrue() {
    let result = sut.allowsDefaultTighteningForTruncation

    XCTAssertTrue(result, "`allowsDefaultTighteningForTruncation` must be true when initialized.")
  }
}
