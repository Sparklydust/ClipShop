//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation

/// Protocol to make a request data on the ClipShop server.
protocol ServerServiceProtocol {
  
  /// Initiates a network request to the specified server endpoint, expecting a response
  /// of the given data type.
  /// - Parameters:
  ///   - endpoint: The ``ServerEndpoint`` URL to request the data.
  ///   - dataType: The type of the expected response data.
  /// - Returns: An instance of the requested data.
  /// - Throws: An error if the request fails.
  func get<T: Codable>(
    atEndpoint endpoint: ServerEndpoint,
    for dataType: T.Type
  ) async throws -> T
}
