//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class ShopDetailsViewModelTests: BaseXCTestCase {

  var sut: ShopDetailsViewModel!

  override func setUp() async throws {
    try await super.setUp()
    sut = ShopDetailsViewModel(server: serverDummy)
  }

  override func tearDown() async throws {
    sut = .none
    try await super.tearDown()
  }
}
