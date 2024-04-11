//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class ComponentSizeTests: XCTestCase {

  func testCase_small_isNotNil() {
    let result = ComponentSize.small

    XCTAssertNotNil(result, "\(result) must exist as a ComponentSize case")
  }

  func testCase_large_isNotNil() {
    let result = ComponentSize.large

    XCTAssertNotNil(result, "\(result) must exist as a ComponentSize case")
  }
}
