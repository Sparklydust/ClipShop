//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// Responsible to request data to the ClipShop server.
final class ServerService: ServerProtocol {

  var urlSession: URLSessionProtocol
  var imageCache: ImageCacheProtocol

  init(
    urlSession: URLSessionProtocol = URLSession.shared,
    imageCache: ImageCacheProtocol = ImageCacheService()
  ) {
    self.urlSession = urlSession
    self.imageCache = imageCache
  }
}

// MARK: - Requests
extension ServerService {

  func get<T: Codable>(
    _ data: T.Type,
    atEndpoint endpoint: ServerEndpoint
  ) async throws -> T {

    let (data, response) = try await urlSession.data(from: endpoint.url)

    guard let httpResponse = response as? HTTPURLResponse,
          200..<300 ~= httpResponse.statusCode
    else { throw ServerError.requestFails }

    return try JSONDecoder().decode(T.self, from: data)
  }

  func loadImage(urlString: String) async -> UIImage? {
    guard let url = URL(string: urlString) else { return .none }
    let fileName = urlString.extractedFileName

    if let cachedData = try? await imageCache.read(name: fileName) {
      return UIImage(data: cachedData)
    }

    do {
      let data = try await urlSession.data(from: url).0
      try await imageCache.write(data, name: fileName)
      return UIImage(data: data)
    } catch { return .none }
  }
}
