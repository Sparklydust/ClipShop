//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class BaseXCTestCase: XCTestCase {

  override func setUp() async throws {
    try await super.setUp()
    // Intentionally empty
  }

  override func tearDown() async throws {
    // Intentionally empty
    try await super.tearDown()
  }
}
