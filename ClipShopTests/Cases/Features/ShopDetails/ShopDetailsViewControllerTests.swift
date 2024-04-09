//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class ShopDetailsViewControllerTests: XCTestCase {

  var sut: ShopDetailsViewController!

  override func setUp() async throws {
    try await super.setUp()
    sut = await ShopDetailsViewController()
  }

  override func tearDown() async throws {
    sut = nil
    try await super.tearDown()
  }
}
