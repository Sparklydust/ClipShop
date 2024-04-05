//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

extension XCTestCase {
  
  /// Creates a mock ``URLSession`` configured with fake response data, an HTTP response, 
  /// and an optional error, facilitating the simulation of API calls for unit testing
  /// purposes.
  /// - Parameters:
  ///   - dataFake: The fake data that is expected to come back from the fake api call for
  ///   tests, found in the `JsonFileName.swift` file as a result of a request.
  ///   - file: The file where the test fails.
  ///   - line: The line of code where the test fails.
  /// - Returns: A ``URLSessionMock`` instance configured with the specified fake data,
  /// HTTP response, and an optional error, ready for use in unit tests to simulate and
  /// verify the handling of API responses and errors.
  func urlSessionMock(
    data dataFake: JsonFileName,
    file: StaticString = #filePath,
    line: UInt = #line
  ) throws -> URLSessionMock {

    let data = try json(fake: dataFake, file: file, line: line)
    let response = try XCTUnwrap(HTTPURLResponse(
      url: try XCTUnwrap(URL(string: "https://fake.api.request.com")),
      statusCode: dataFake == .errorData ? 500 : 200,
      httpVersion: .none,
      headerFields: .none
    ))
    let error: ServerError? = dataFake == .errorData ? .requestFails : .none

    return URLSessionMock(data: data, response: response, error: error)
  }
}
