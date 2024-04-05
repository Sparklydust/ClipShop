//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class ServerServiceTests: XCTestCase {

  var sut: ServerService!

  override func setUp() async throws {
    try await super.setUp()
    sut = ServerService()
  }

  override func tearDown() async throws {
    sut = .none
    try await super.tearDown()
  }
}
