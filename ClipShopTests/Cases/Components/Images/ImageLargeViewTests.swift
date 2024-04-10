//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class ImageLargeViewTests: XCTestCase {

  var sut: ImageLargeView!

  override func setUp() async throws {
    try await super.setUp()
    sut = await ImageLargeView(frame: .zero)
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

  func testInitialization_clipsToBounds_isEqualToTrue() {
    let result = sut.clipsToBounds

    XCTAssertTrue(result, "`clipsToBounds` must be true when initialized.")
  }
}