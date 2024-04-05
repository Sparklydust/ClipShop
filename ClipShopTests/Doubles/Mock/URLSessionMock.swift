//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation
@testable import ClipShop

final class URLSessionMock: URLSessionProtocol {

  // Mock values
  var data: Data?
  var response: URLResponse?
  var error: ServerError?

  init(
    data: Data? = .none,
    response: URLResponse? = .none,
    error: ServerError? = .none
  ) {
    self.data = data
    self.response = response
    self.error = error
  }

  // Protocol requirements
  func data(from url: URL) async throws -> (Data, URLResponse) {

    guard error == .none,
          let httpResponse = response as? HTTPURLResponse,
          200..<300 ~= httpResponse.statusCode,
          let data = data,
          let response = response
    else { throw error ?? ServerError.requestFails }

    return (data, response)
  }
}
