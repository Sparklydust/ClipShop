//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class PaperclipModelTests: XCTestCase {

  var sut: PaperclipModel!

  override func setUp() async throws {
    try await super.setUp()
    sut = PaperclipModel()
  }

  override func tearDown() async throws {
    sut = nil
    try await super.tearDown()
  }
}
