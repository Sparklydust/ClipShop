//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit
@testable import ClipShop

final class ServerDummy: ServerProtocol {

  // Protocol requirements
  func get<T: Codable>(
    _ data: T.Type,
    atEndpoint endpoint: ServerEndpoint
  ) async throws -> T {
    throw ServerError.requestFails
  }

  func loadImage(urlString: String) async -> UIImage? {
    .none
  }
}
