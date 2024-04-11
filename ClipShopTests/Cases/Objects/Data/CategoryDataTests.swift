//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class CategoryDataTests: XCTestCase {

  func testCodable_requestCategoryData_jsonResponseIsSuccessfullyDecoded() throws {
    let expected: CategoryData = .fake()
    let data = try json(fake: .categoryData)

    let result = try JSONDecoder().decode(CategoryData.self, from: data)

    XCTAssertEqual(result, expected, "Decoded `CategoryData` must be equal to the `CategoryData.json` file content."
    )
  }
}
