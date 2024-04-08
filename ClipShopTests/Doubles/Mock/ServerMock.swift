//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit
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
    let decodedResponse = try JSONDecoder().decode(T.self, from: data.0)

    return decodedResponse
  }

  func loadImage(urlString: String) async -> UIImage? {
    try? onPerformAsyncAwait()

    guard let _ = URL(string: urlString) else { return .none }
    return UIImage(systemName: "gear")
  }
}
