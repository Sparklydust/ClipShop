//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation
@testable import ClipShop

final class ServerSpy: ServerProtocol {

  // Spy values
  var isRequestCalled = false
  var endpoint: ServerEndpoint?
  var dataType: Codable?

  // Protocol requirements
  func get<T: Codable>(
    atEndpoint endpoint: ServerEndpoint,
    for dataType: T.Type
  ) async throws -> T {
    isRequestCalled = true
    self.endpoint = endpoint
    self.dataType = dataType as? any Codable

    throw ServerError.requestFails
  }
}
