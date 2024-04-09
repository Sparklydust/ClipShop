//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class CoordinatorTests: BaseXCTestCase {

  var sut: Coordinator!

  var shopListViewModelFake: ShopListViewModel!

  override func setUp() async throws {
    try await super.setUp()
    shopListViewModelFake = ShopListViewModel(server: serverDummy)

    sut = Coordinator(
      navigationController: navigationControllerDummy,
      shopListViewModel: shopListViewModelFake
    )
  }

  override func tearDown() async throws {
    sut = nil
    shopListViewModelFake = nil
    try await super.tearDown()
  }

  func testNavigations_pushesShopListViewController_resultIsTrue() {
    sut = Coordinator(
      navigationController: navigationControllerSpy,
      shopListViewModel: shopListViewModelFake
    )

    sut.start()
    let result = navigationControllerSpy.viewController is ShopListViewController

    XCTAssertTrue(result, "Coordinator must push `ShopListViewController` in the navigation stack on `start()`.")
  }
}
