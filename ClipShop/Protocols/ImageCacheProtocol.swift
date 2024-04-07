//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation

protocol ImageCacheProtocol {

  /// Writes image data to disk storage with the specified file name.
  ///
  /// Implements an efficient image caching strategy utilizing both in-memory and disk storage.
  /// This caching system stores images temporarily in memory for quick access, and persistently on 
  /// disk for long-term storage. The dual-layer approach optimizes performance and resource usage
  /// by prioritizing faster memory access for recently or frequently accessed images, while 
  /// ensuring less frequently accessed images are still available from disk storage, albeit with
  /// slightly longer retrieval times.
  /// - Parameters:
  ///   - data: The data to save in disk.
  ///   - name: The name of the data to save.
  func write(_ data: Data, name: String) async throws

  /// Reads and returns image data from disk storage for a given file name.
  ///
  /// This method facilitates retrieving images from the disk cache, which is particularly useful
  /// for images that are not currently stored in memory due to infrequent access or memory cache
  /// eviction policies. By providing a secondary storage option, the dual-layer caching strategy
  /// ensures that image retrieval remains efficient without relying solely on network fetches or
  /// image regeneration.
  /// - Parameter name: The name of the saved data.
  /// - Returns: The data found in disk.
  func read(name: String) async throws -> Data
}
