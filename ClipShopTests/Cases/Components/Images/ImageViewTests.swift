//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class ImageViewTests: XCTestCase {

  var sut: ImageView!

  override func setUp() async throws {
    try await super.setUp()
    sut = await ImageView(size: .small)
  }

  override func tearDown() async throws {
    sut = nil
    try await super.tearDown()
  }

  func testInitialization_contentMode_isEqualToScaleAspectFill() {
    let expected: UIView.ContentMode = .scaleAspectFill

    let result = sut.contentMode

    XCTAssertEqual(result, expected, "`contentMode` must be equal to `\(expected)` when initialized.")
  }

  func testInitialization_layerCornerRadiusForSmallView_isEqualTo8() {
    sut = ImageView(size: .small)
    let expected: CGFloat = 8

    let result = sut.layer.cornerRadius

    XCTAssertEqual(result, expected, "`layer.cornerRadius` must be equal to `\(expected)` when initialized.")
  }

  func testInitialization_layerCornerRadiusForLargeView_isEqualToZero() {
    sut = ImageView(size: .large)
    let expected: CGFloat = .zero

    let result = sut.layer.cornerRadius

    XCTAssertEqual(result, expected, "`layer.cornerRadius` must be equal to `\(expected)` when initialized.")
  }

  func testInitialization_clipsToBounds_isEqualToTrue() {
    let result = sut.clipsToBounds

    XCTAssertTrue(result, "`clipsToBounds` must be true when initialized.")
  }
}
