//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation

/// Add URLSessionProtocol on top of ``URLSession`` to reduce the dependency for testing.
extension URLSession: URLSessionProtocol {

  /// Define an async method that wraps the standard callback API that is only available on iOS 15+.
  @available(iOS, deprecated: 15.0, message: "This extension is no longer necessary. Use API built into SDK.")
  func data(from url: URL) async throws -> (Data, URLResponse) {
    try await withCheckedThrowingContinuation { continuation in
      let task = self.dataTask(with: url) { data, response, error in
        guard let data = data, let response = response else {
          let error = error ?? URLError(.badServerResponse)
          return continuation.resume(throwing: error)
        }
        continuation.resume(returning: (data, response))
      }
      task.resume()
    }
  }
}

/// Nods the head on top of ``URLSession`` to reduce the dependency for testing and insert
/// it in as a dependency injection.
protocol URLSessionProtocol {

  /// Retrieves the contents of a URL and delivers the data asynchronously.
  ///
  /// Use this method to wait until the session finishes transferring data and receive it
  /// in a single Data instance.
  /// - Parameter url: The URL to retrieve.
  /// - Returns: An asynchronously-delivered tuple that contains the URL contents as a Data
  /// instance, and a URLResponse.
  func data(from url: URL) async throws -> (Data, URLResponse)
}
