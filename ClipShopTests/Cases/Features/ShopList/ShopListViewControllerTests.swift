//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class ShopListViewControllerTests: BaseXCTestCase {

  var sut: ShopListViewController!

  var viewModelFake: ShopListViewModel!

  override func setUp() async throws {
    try await super.setUp()
    viewModelFake = ShopListViewModel(server: serverDummy)
    sut = await ShopListViewController(viewModel: viewModelFake)
  }

  override func tearDown() async throws {
    viewModelFake = nil
    sut = nil
    try await super.tearDown()
  }

  func testInitialization_viewBackgroundColor_isEqualToSystemBackground() {
    let expected: UIColor = .systemBackground

    let result = sut.view.backgroundColor

    XCTAssertEqual(result, expected, "View `backgroundColor` must be equal to `\(expected)`.")
  }

  func testInitialization_activityIndicatorColor_isEqualToAccent() {
    let expected: UIColor = .accent

    let result = sut.activityIndicator.color

    XCTAssertEqual(result, expected, "`activityIndicator` color must be equal to `\(expected)`.")
  }
}
