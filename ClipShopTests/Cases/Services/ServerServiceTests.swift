//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class ServerServiceTests: BaseXCTestCase {

  var sut: ServerService!

  override func setUp() async throws {
    try await super.setUp()
    sut = ServerService(urlSession: urlSessionMock)
  }

  override func tearDown() async throws {
    sut = .none
    try await super.tearDown()
  }

  func testRequests_isSuccessfulWhenRequestingCategoryData_requestedDataIsReturned() {
    XCTAssert(false, "Test not yet implemented")
  }

  func testRequests_isNotSuccessful_requestFailsServerErrorIsThrown() {
    XCTAssert(false, "Test not yet implemented")
  }
}
