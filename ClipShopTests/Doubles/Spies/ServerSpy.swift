//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation
@testable import ClipShop

final class ServerSpy: ServerProtocol {

  // Spy values
  var isRequestCalled = false
  var endpoint: ServerEndpoint?
  var data: Codable?

  // Protocol requirements
  func get<T: Codable>(
    _ data: T.Type,
    atEndpoint endpoint: ServerEndpoint
  ) async throws -> T {
    isRequestCalled = true
    self.endpoint = endpoint
    self.data = data as? any Codable

    throw ServerError.requestFails
  }
}
