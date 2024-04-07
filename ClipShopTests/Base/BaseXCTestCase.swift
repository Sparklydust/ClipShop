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

  var imageCacheDummy: ImageCacheDummy!
  var serverDummy: ServerDummy!
  var imageCacheMock: ImageCacheMock!
  var fileManagerMock: FileManagerMock!
  var urlSessionMock: URLSessionMock!
  var serverMock: ServerMock!
  var imageCacheSpy: ImageCacheSpy!
  var serverSpy: ServerSpy!

  override func setUp() async throws {
    try await super.setUp()
    imageCacheDummy = ImageCacheDummy()
    serverDummy = ServerDummy()
    imageCacheMock = ImageCacheMock()
    fileManagerMock = FileManagerMock()
    urlSessionMock = try urlSessionMock(data: .categoryData)
    serverMock = try serverMock(data: .categoryData)
    imageCacheSpy = ImageCacheSpy()
    serverSpy = ServerSpy()
  }

  override func tearDown() async throws {
    serverSpy = nil
    imageCacheSpy = nil
    serverMock = nil
    urlSessionMock = nil
    fileManagerMock = nil
    imageCacheMock = nil
    serverDummy = nil
    imageCacheDummy = nil
    try await super.tearDown()
  }
}
