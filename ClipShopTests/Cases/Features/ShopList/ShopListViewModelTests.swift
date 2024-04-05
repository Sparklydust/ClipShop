//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class ShopListViewModelTests: BaseXCTestCase {

  var sut: ShopListViewModel!

  override func setUp() async throws {
    try await super.setUp()
    sut = ShopListViewModel(server: serverSpy)
  }

  override func tearDown() async throws {
    sut = .none
    try await super.tearDown()
  }
}
