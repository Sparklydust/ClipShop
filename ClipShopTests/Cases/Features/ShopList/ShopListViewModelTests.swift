//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class ShopListViewModelTests: BaseXCTestCase {

  var sut: ShopListViewModel!

  override func setUp() async throws {
    try await super.setUp()
    sut = ShopListViewModel(server: serverDummy)
  }

  override func tearDown() async throws {
    sut = .none
    try await super.tearDown()
  }

  func testInitialization_paperclips_isEqualToEmptyArrayOfPaperclipModel() {
    let expected = [PaperclipModel]()

    let result = sut.paperclips

    XCTAssertEqual(result, expected, "`paperclips` value must be equal to `\(expected)` when initialized.")
  }

  func testInitialization_categories_isEqualToEmptyArrayOfCategoryModel() {
    let expected = [CategoryModel]()

    let result = sut.categories

    XCTAssertEqual(result, expected, "`categories` value must be equal to `\(expected)` when initialized.")
  }

  func testInitialization_showError_isFalse() {
    let result = sut.showError

    XCTAssertFalse(result, "`showError` must be false when first initialized.")
  }

  func testInitialization_isLoading_isFalse() {
    let result = sut.isLoading

    XCTAssertFalse(result, "`isLoading` must be false when first initialized.")
  }

  func testServerService_requestListOfPaperclipDataIsTriggered_isLoadingIsTrue() async {
    sut = ShopListViewModel(server: serverMock)

    serverMock.onPerformAsyncAwait = {
      let result = self.sut.isLoading

      XCTAssertTrue(result, "`isLoading` must be true when data are loading.")
    }
    await sut.getPaperclipsList()
  }

  func testServerService_requestListOfPaperclipDataIsSuccessful_isLoadingIsFalse() async {
    sut.isLoading = true

    await sut.getPaperclipsList()
    let result = sut.isLoading

    XCTAssertFalse(result, "`isLoading` must be false when data loaded.")
  }

  func testServerService_requestListOfPaperclipDataIsSuccessful_paperlicpsValueIsNotEmpty() async throws {
    try XCTSkipIf(true, "Must manage to mock more than one async request to avoid error being thrown as concurrents requests are being made.")
    serverMock = try serverMock(data: .paperclipsData)
    sut = ShopListViewModel(server: serverMock)
    sut.paperclips.removeAll()

    await sut.getPaperclipsList()
    let result = sut.paperclips.isEmpty

    XCTAssertFalse(result, "`paperclips` must not empty on a successful request.")
  }

  func testServerService_requestListOfPaperclipDataIsNotSuccessful_paperlicpsValueIsEmpty() async throws {
    sut = ShopListViewModel(server: try serverMock(data: .errorData))
    sut.paperclips.removeAll()

    await sut.getPaperclipsList()
    let result = sut.paperclips.isEmpty

    XCTAssertTrue(result, "`paperclips` must be empty when the serve request fails.")
  }

  func testServerService_requestListOfPaperclipDataFailsWithError_showErrorValueIsTrue() async throws {
    sut = ShopListViewModel(server: try serverMock(data: .errorData))

    await sut.getPaperclipsList()
    let result = sut.showError

    XCTAssertTrue(result, "`showError` must be true when an error is triggered from the server.")
  }

  func testServerService_requestListOfPaperclipDataIsSuccessful_showErrorValueIsFalse() async throws {
    try XCTSkipIf(true, "Must manage to mock more than one async request to avoid error being thrown as concurrents requests are being made.")
    serverMock = try serverMock(data: .paperclipsData)
    sut = ShopListViewModel(server: serverMock)

    await sut.getPaperclipsList()
    let result = sut.showError

    XCTAssertFalse(result, "`showError` must be false when the server request is successful.")
  }

  func testServerService_isSuccessfulWhenLoadingImage_returnedUIImageIsNotNil() async throws {
    serverMock = try serverMock(data: .imageData)
    sut = ShopListViewModel(server: serverMock)

    let result = await sut.loadImage(urlString: "www.fake.url.com")

    XCTAssertNotNil(result, "`loadImage(urlString:)` must return an UIImage on a successful request.")
  }

  func testServerService_isNotSuccessfulWhenLoadingImage_returnedUIImageIsNil() async throws {
    serverMock = try serverMock(data: .errorData)
    sut = ShopListViewModel(server: serverMock)

    let result = await sut.loadImage(urlString: "")

    XCTAssertNil(result, "No UIImage must be returned on a request failure.")
  }
}
