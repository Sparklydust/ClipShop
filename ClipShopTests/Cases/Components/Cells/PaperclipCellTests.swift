//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class PaperclipCellTests: XCTestCase {

  var sut: PaperclipCell!

  override func setUp() async throws {
    try await super.setUp()
    sut = await PaperclipCell(frame: .zero)
  }

  override func tearDown() async throws {
    sut = nil
    try await super.tearDown()
  }

  func testInitializer_reuseIdentifier_isEqualToPaperclipCellString() {
    let expected = "PaperclipCell"

    let result = PaperclipCell.reuseIdentifier

    XCTAssertEqual(result, expected, "Cell `reuseIdentifier` must be equal to `\(expected)` when initialized.")
  }
}
