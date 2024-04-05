//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

extension XCTestCase {
  
  /// Creates a mock implementation of the ``ServerService`` protocol configured with a 
  /// mocked server response, facilitating the testing of components that interact with
  /// server services.
  /// - Parameters:
  ///   - data: The fake data that is expected to come back from the fake api call for
  ///   tests, found in the `JsonFileName.swift` file as a result of a request.
  ///   - file: The file where the test fails.
  ///   - line: The line of code where the test fails.
  /// - Returns: An instance conforming to ``ServerProtocol``, mocked with the specified
  /// `data` parameter.
  func serverMock(
    data: JsonFileName,
    file: StaticString = #filePath,
    line: UInt = #line
  ) throws -> ServerMock {

    let urlSessionMock = try urlSessionMock(data: data, file: file, line: line)
    return ServerMock(urlSession: urlSessionMock)
  }
}
