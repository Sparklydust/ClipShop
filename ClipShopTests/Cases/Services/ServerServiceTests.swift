//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class ServerServiceTests: BaseXCTestCase {

  var sut: ServerService!

  override func setUp() async throws {
    try await super.setUp()
    sut = ServerService(urlSession: urlSessionMock)
  }

  override func tearDown() async throws {
    sut = .none
    try await super.tearDown()
  }

  func testRequests_isSuccessfulWhenRequestingCategoryData_requestedDataIsReturned() async throws {
    let expected: CategoryData = .fake()
    urlSessionMock = try urlSessionMock(data: .categoryData)
    sut = ServerService(urlSession: urlSessionMock)

    let result = try await sut.get(CategoryData.self, atEndpoint: .paperclipCategories)

    XCTAssertEqual(result, expected, "A successful request must return the `\(expected)` data object.")
  }

  func testRequests_isNotSuccessful_requestFailsServerErrorIsThrown() async throws {
    let expected: ServerError = .requestFails
    urlSessionMock = try urlSessionMock(data: .errorData)
    sut = ServerService(urlSession: urlSessionMock)

    do {
      _ = try await sut.get(CategoryData.self, atEndpoint: .paperclipCategories)
      XCTFail("Must not response with valid data as an error must be thrown.")
    } catch let error {
      let result = try XCTUnwrap(error as? ServerError)

      XCTAssertEqual(result, expected, "Unsuccessful request must throw `\(expected)` error.")
    }
  }

  func testRequests_isSuccessfulWhenLoadingImage_returnUIImageIsNotNil() async throws {
    urlSessionMock = try urlSessionMock(data: .imageData)
    sut = ServerService(urlSession: urlSessionMock)

    let result = await sut.loadImage(urlString: "www.fake.url.com")

    XCTAssertNotNil(result, "`loadImage(urlString:)` must return an UIImage on a successful request.")
  }

  func testRequests_isNotSuccessfulWhenLoadingImage_returnUIImageIsNil() async throws {
    urlSessionMock = try urlSessionMock(data: .errorData)
    sut = ServerService(urlSession: urlSessionMock)

    let result = await sut.loadImage(urlString: "")

    XCTAssertNil(result, "No UIImage must be returned on a request failure.")
  }
}
