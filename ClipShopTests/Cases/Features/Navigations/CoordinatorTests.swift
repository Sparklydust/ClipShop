//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class CoordinatorTests: BaseXCTestCase {

  var sut: Coordinator!

  var shopListViewModelFake: ShopListViewModel!
  var shopDetailsViewModelFake: ShopDetailsViewModel!

  override func setUp() async throws {
    try await super.setUp()
    shopListViewModelFake = ShopListViewModel(server: serverDummy)
    shopDetailsViewModelFake = ShopDetailsViewModel(server: serverDummy)

    sut = Coordinator(
      navigationController: navigationControllerSpy,
      shopDetailsViewModel: shopDetailsViewModelFake,
      shopListViewModel: shopListViewModelFake
    )
  }

  override func tearDown() async throws {
    sut = nil
    shopDetailsViewModelFake = nil
    shopListViewModelFake = nil
    try await super.tearDown()
  }

  func testNavigations_pushesShopListViewController_resultIsTrue() {
    sut.start()
    let result = navigationControllerSpy.viewController is ShopListViewController

    XCTAssertTrue(result, "Coordinator must push `ShopListViewController` in the navigation stack on `start()`.")
  }

  func testNavigations_didSelectPaperclipItemIsTriggered_navigationPushShopDetailsViewController() {
    sut.start()

    sut.didSelectItem(.fake())
    let result = navigationControllerSpy.viewController is ShopDetailsViewController

    XCTAssertTrue(result, "Coordinator must push `ShopDetailsViewController` in the navigation stack on `didSelectItem(_:)`.")
  }
}
