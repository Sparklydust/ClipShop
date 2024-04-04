//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class ShopListViewControllerTests: XCTestCase {

  var sut: ShopListViewController!

  override func setUp() async throws {
    try await super.setUp()
    sut = await ShopListViewController()
  }

  override func tearDown() async throws {
    sut = .none
    try await super.tearDown()
  }

  func testInitialization_viewBackgroundColor_isEqualToSystemBackground() {
    let expected: UIColor = .systemBackground

    let result = sut.view.backgroundColor

    XCTAssertEqual(result, expected, "View `backgroundColor` must be equal to `\(expected)`.")
  }
}
