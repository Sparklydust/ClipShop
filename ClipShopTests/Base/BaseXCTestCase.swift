//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

/// Setup and tear down Doubles to be shared with all tests subclasses when needed.
///
/// By adding the ``BaseXCTestCase`` as an extension to tests class, we can avoid duplications
/// and retrieve all dummies, mocks and spies in one place.
class BaseXCTestCase: XCTestCase {

  var serverDummy: ServerDummy!
  var urlSessionMock: URLSessionMock!
  var serverMock: ServerMock!
  var serverSpy: ServerSpy!

  override func setUp() async throws {
    try await super.setUp()
    serverDummy = ServerDummy()
    urlSessionMock = try urlSessionMock(data: .categoryData)
    serverMock = try serverMock(data: .categoryData)
    serverSpy = ServerSpy()
  }

  override func tearDown() async throws {
    serverSpy = nil
    serverMock = nil
    urlSessionMock = nil
    serverDummy = nil
    try await super.tearDown()
  }
}
