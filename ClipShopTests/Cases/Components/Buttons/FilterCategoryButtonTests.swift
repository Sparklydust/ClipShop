//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class FilterCategoryButtonTests: XCTestCase {

  var sut: FilterCategoryButton!

  override func setUp() async throws {
    try await super.setUp()
    sut = await FilterCategoryButton()
  }

  override func tearDown() async throws {
    sut = nil
    try await super.tearDown()
  }
}
