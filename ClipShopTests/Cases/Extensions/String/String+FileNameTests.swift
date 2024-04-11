//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class String_FileNameTests: XCTestCase {

  func testFileName_imageNameAssigned_returnImageName() {
    let fakeName = ["http://example.com/thumb/image.png": "thumb-image.png"]

    for (result, expected) in fakeName {
      XCTAssertEqual(result.extractedFileName, expected, "`extractedFileName` must match `\(expected)` value.")
    }
  }
}
