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

  func testServerService_requestListOfPaperclipDataIsTriggered_isLoadingIsTrue() async {
    sut = ShopListViewModel(server: serverMock)
    sut.isLoading = false

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

  func testServerService_requestListOfPaperclipDataIsSuccessful_paperlicpsValueIsNotEmpty() {
    XCTAssert(false, "Test not yet implemented")
  }

  func testServerService_requestListOfPaperclipDataIsNotSuccessful_paperlicpsValueIsEmpty() {
    XCTAssert(false, "Test not yet implemented")
  }

  func testServerService_requestListOfPaperclipDataFailsWithError_showErrorValueIsTrue() {
    XCTAssert(false, "Test not yet implemented")
  }

  func testServerService_requestListOfPaperclipDataIsSuccessful_showErrorValueIsFalse() {
    XCTAssert(false, "Test not yet implemented")
  }
}
