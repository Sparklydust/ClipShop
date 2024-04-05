//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation

/// Responsible to request data to the ClipShop server.
final class ServerService: ServerProtocol {

  var urlSession: URLSessionProtocol

  init(urlSession: URLSessionProtocol = URLSession.shared) {
    self.urlSession = urlSession
  }
}

// MARK: - Requests
extension ServerService {

  func get<T: Codable>(
    atEndpoint endpoint: ServerEndpoint,
    for dataType: T.Type
  ) async throws -> T {

    let (data, response) = try await urlSession.data(from: endpoint.url)

    guard let httpResponse = response as? HTTPURLResponse,
          200..<300 ~= httpResponse.statusCode
    else { throw ServerError.requestFails }

    return try JSONDecoder().decode(T.self, from: data)
  }
}
