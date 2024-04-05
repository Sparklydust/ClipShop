//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation
@testable import ClipShop

final class ServerMock: ServerProtocol {

  // Protocol requirements
  func get<T: Codable>(
    atEndpoint endpoint: ServerEndpoint,
    for dataType: T.Type
  ) async throws -> T {
    throw ServerError.requestFails
  }
}
