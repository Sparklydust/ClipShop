//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class CoordinatorTests: XCTestCase {

  var sut: Coordinator!

  override func setUp() async throws {
    try await super.setUp()
    sut = Coordinator()
  }

  override func tearDown() async throws {
    sut = nil
    try await super.tearDown()
  }
}
