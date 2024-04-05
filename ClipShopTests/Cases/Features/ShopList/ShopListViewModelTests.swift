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

  func testServerService_requestListOfPaperclipDataIsTriggered_isLoadingIsTrue() {
    XCTAssert(false, "Test not yet implemented")
  }

  func testServerService_requestListOfPaperclipDataIsSuccessful_isLoadingIsFalse() {
    XCTAssert(false, "Test not yet implemented")
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
