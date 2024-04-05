//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

extension XCTestCase {
  
  /// Mock ``ServerService`` with needed parameters to create a fake server request.
  /// - Parameters:
  ///   - dataFake: The fake data that is expected to come back from the fake api call for
  ///   tests, found in the `JsonFileName.swift` file as a result of a request.
  ///   - file: The file where the test fails.
  ///   - line: The line of code where the test fails.
  /// - Returns: A fake server response mocked following passed `data` parameter.
  func serverMock(
    data dataFake: JsonFileName,
    file: StaticString = #filePath,
    line: UInt = #line
  ) throws -> ServerProtocol {

    let data = try json(fake: dataFake, file: file, line: line)
    let response = try XCTUnwrap(HTTPURLResponse(
      url: URL(string: "https://fake.api.request.com")!,
      statusCode: dataFake == .errorData ? 500 : 200,
      httpVersion: .none,
      headerFields: .none
    ))
    let error: ServerError? = dataFake == .errorData ? .requestFails : .none

    let urlSessionMock = URLSessionMock(data: data, response: response, error: error)

    return ServerMock(urlSession: urlSessionMock)
  }
}
