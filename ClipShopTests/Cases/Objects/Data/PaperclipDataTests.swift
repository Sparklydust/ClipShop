//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class PaperclipDataTests: XCTestCase {

  func testCodable_requestPaperclipData_jsonResponseIsSuccessfullyDecoded() throws {
    let expected: PaperclipData = .fake()
    let data = try json(fake: .paperclipData)

    let result = try JSONDecoder().decode(PaperclipData.self, from: data)

    XCTAssertEqual(result, expected, "Decoded `PaperclipData` must be equal to the `PaperclipData.json` file content."
    )
  }
}
