//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class ShopDetailsViewControllerTests: XCTestCase {

  var sut: ShopDetailsViewController!

  override func setUp() async throws {
    try await super.setUp()
    sut = await ShopDetailsViewController(paperclip: .fake())
    await sut.loadViewIfNeeded()
  }

  override func tearDown() async throws {
    sut = nil
    try await super.tearDown()
  }

  func testInitialization_viewBackgroundColor_isEqualToSystemBackground() {
    let expected: UIColor = .systemBackground

    let result = sut.view.backgroundColor

    XCTAssertEqual(result, expected, "View `backgroundColor` must be equal to `\(expected)`.")
  }

  func testInitialization_title_isEqualToPassedPaperclipCategoryNamePassedInInit() {
    let expected = PaperclipModel.fake().category.name

    let result = sut.title

    XCTAssertEqual(result, expected, "View `title` must be equal to `\(expected)`.")
  }
}
