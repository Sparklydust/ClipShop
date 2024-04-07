//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class ImageCacheErrorTests: XCTestCase {

  func testCase_dataNotFound_isNotNil() {
    let result = ImageCacheError.dataNotFound

    XCTAssertNotNil(result, "\(result) must exist as a ImageCacheError case")
  }
}
