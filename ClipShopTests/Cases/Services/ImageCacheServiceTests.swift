//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class ImageCacheServiceTests: BaseXCTestCase {

  var sut: ImageCacheService!

  override func setUp() async throws {
    try await super.setUp()
    sut = ImageCacheService(fileManager: fileManagerMock)
  }

  override func tearDown() async throws {
    sut = nil
    try await super.tearDown()
  }
}
