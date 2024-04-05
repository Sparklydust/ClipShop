//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation

/// Server contract for requesting data on the ClipShop server.
protocol ServerProtocol {
  
  /// Initiates a network request to the specified server endpoint, expecting a response
  /// of the given data type.
  /// - Parameters:
  ///   - data: The type of the expected response data.
  ///   - endpoint: The ``ServerEndpoint`` URL to request the data.
  /// - Returns: An instance of the requested data.
  /// - Throws: An error if the request fails.
  func get<T: Codable>(
    _ data: T.Type,
    atEndpoint endpoint: ServerEndpoint
  ) async throws -> T
}
