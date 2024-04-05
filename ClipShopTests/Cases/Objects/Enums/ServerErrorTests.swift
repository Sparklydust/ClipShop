//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class ServerErrorTests: XCTestCase {

  func testCase_requestFails_isNotNil() {
    let result = ServerError.requestFails

    XCTAssertNotNil(result, "\(result) must exist as a ServerError case")
  }
}
