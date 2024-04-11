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

  var coordinatorDummy: CoordinatorDummy!
  var imageCacheDummy: ImageCacheDummy!
  var serverDummy: ServerDummy!
  var navigationControllerDummy: NavigationControllerDummy!

  var coordinatorMock: CoordinatorMock!
  var imageCacheMock: ImageCacheMock!
  var fileManagerMock: FileManagerMock!
  var navigationControllerMock: NavigationControllerMock!
  var urlSessionMock: URLSessionMock!
  var serverMock: ServerMock!

  var coordinatorSpy: CoordinatorSpy!
  var imageCacheSpy: ImageCacheSpy!
  var navigationControllerSpy: NavigationControllerSpy!
  var serverSpy: ServerSpy!

  override func setUp() async throws {
    try await super.setUp()
    navigationControllerDummy = await NavigationControllerDummy(nibName: .none, bundle: .none)
    coordinatorDummy = await CoordinatorDummy(navigationController: navigationControllerDummy)
    imageCacheDummy = ImageCacheDummy()
    serverDummy = ServerDummy()

    navigationControllerMock = await NavigationControllerMock(nibName: .none, bundle: .none)
    coordinatorMock = await CoordinatorMock(navigationController: navigationControllerMock)
    imageCacheMock = ImageCacheMock()
    fileManagerMock = FileManagerMock()
    urlSessionMock = try urlSessionMock(data: .categoryData)
    serverMock = try serverMock(data: .categoryData)

    navigationControllerSpy = await NavigationControllerSpy(nibName: .none, bundle: .none)
    coordinatorSpy = await CoordinatorSpy(navigationController: navigationControllerSpy)
    imageCacheSpy = ImageCacheSpy()
    serverSpy = ServerSpy()
  }

  override func tearDown() async throws {
    serverSpy = nil
    imageCacheSpy = nil
    coordinatorSpy = nil
    navigationControllerSpy = nil
    serverMock = nil
    urlSessionMock = nil
    fileManagerMock = nil
    imageCacheMock = nil
    coordinatorMock = nil
    navigationControllerMock = nil
    serverDummy = nil
    imageCacheDummy = nil
    coordinatorDummy = nil
    navigationControllerDummy = nil
    try await super.tearDown()
  }
}
