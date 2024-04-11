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
    sut = nil
    try await super.tearDown()
  }

  func testInitialization_itemImage_isEqualToUIImageNil() {
    let expected: UIImage? = .none

    let result = sut.itemImage

    XCTAssertEqual(result, expected, "`itemImage` value must be equal to `\(String(describing: expected))` when initialized.")
  }

  func testServerService_isSuccessfulWhenLoadingThumbImage_iItemImageValueIsNotNil() async throws {
    serverMock = try serverMock(data: .imageData)
    sut = ShopDetailsViewModel(server: serverMock)

    await sut.loadImage(for: .fake())
    let result = sut.itemImage

    XCTAssertNotNil(result, "`loadImage(urlString:)` must return an UIImage on a successful request.")
  }

  func testServerService_isNotSuccessfulWhenLoadingImage_itemImageValueIsNil() async throws {
    serverMock = try serverMock(data: .errorData)
    sut = ShopDetailsViewModel(server: serverMock)

    await sut.loadImage(for: .fake(with: (.fake(imageURLs: .fake(thumb: .none)), [])))
    let result = sut.itemImage

    XCTAssertNil(result, "No UIImage must be returned on a request failure.")
  }
}
