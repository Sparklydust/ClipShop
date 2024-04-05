//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest

// MARK: - Json Fake
extension XCTestCase {

  /// Retrieve de json file from the Doubles/Objects/Data folder in AppTests to pass
  /// server data in unit tests.
  /// - Parameters:
  ///   - named: The name of the json file to decode.
  ///   - file: The file where the test fails.
  ///   - line: The line code where the test fails.
  /// - Returns: The json model as data.
  func json(
    fake named: JsonFileName,
    file: StaticString = #file,
    line: UInt = #line
  ) throws -> Data {
    let bundleURL = try XCTUnwrap(
      Bundle(for: type(of: self)).url(forResource: named.rawValue, withExtension: "json"),
      "`\(named.rawValue)` was not found as a `JsonFileName` declaration.",
      file: file,
      line: line
    )
    return try Data(contentsOf: bundleURL)
  }
}
