//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation
@testable import ClipShop

final class ServerMock: ServerProtocol {

  // Mock values
  /// Pass inside ``ServerMock`` protocol methods to catch up works being perform during
  /// asynchronous requests.
  ///
  /// Used to unit tests asynchronous methods by stopping the work of an async/await work.
  var onPerformAsyncAwait: () throws -> Void = {}

  let urlSessionMock: URLSessionProtocol

  init(urlSession: URLSessionProtocol) {
    urlSessionMock = urlSession
  }

  // Protocol requirements
  func get<T: Codable>(
    _ data: T.Type,
    atEndpoint endpoint: ServerEndpoint
  ) async throws -> T {
    try onPerformAsyncAwait()

    let data = try await urlSessionMock.data(from: endpoint.url)
    guard let dataResponse = data.0 as? T else { throw ServerError.requestFails }

    return dataResponse
  }
}
