//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit
@testable import ClipShop

final class ServerSpy: ServerProtocol {

  // Spy values
  var isGetCalled = false
  var isLoadImageCalled = false
  var endpoint: ServerEndpoint?
  var data: Codable?
  var urlString: String?

  // Protocol requirements
  func get<T: Codable>(
    _ data: T.Type,
    atEndpoint endpoint: ServerEndpoint
  ) async throws -> T {
    isGetCalled = true
    self.endpoint = endpoint
    self.data = data as? any Codable

    throw ServerError.requestFails
  }

  func loadImage(urlString: String) async -> UIImage? {
    self.urlString = urlString
    return .none
  }
}
