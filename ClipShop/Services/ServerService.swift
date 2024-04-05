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
    return PaperclipData(
      id: .zero,
      categoryID: .zero,
      title: "",
      description: "",
      price: .zero,
      imageURLs: .init(small: .none, thumb: .none),
      creationDate: "",
      isUrgent: false,
      siret: .none
    ) as! T
  }
}
