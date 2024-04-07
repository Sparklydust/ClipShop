//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation
import OSLog

/// A storage service for images managing data in disk storage using a specified folder
/// within the Application Support directory.
final class ImageCacheService: ImageCacheProtocol {

  /// Main Information attributes about a saved image in ``FileManager``.
  typealias SavedImageInfo = [(url: URL, lastAccessed: Date, size: Int)]

  /// The URL of the folder within Application Support Directory to be used for storage.
  private var cacheDirectory: URL

  /// The memory limit that can be used to cache images.
  private let memoryLimit = Int(1e+9) // 1GB
  private let inMemoryCache = NSCache<NSString, NSData>()

  let fileManager: FileManagerProtocol

  init(fileManager: FileManagerProtocol = FileManager.default) {
    cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[.zero]
      .appendingPathComponent("clipshop_database", isDirectory: true)
    self.fileManager = fileManager
    try? setupCacheDirectory()
  }
}

// MARK: - Setup
extension ImageCacheService {

  /// Initializes a new disk storage service, creating the storage directory if it does not exist.
  private func setupCacheDirectory() throws {
    do {
      try fileManager
        .createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: .none)
    } catch { Logger().error("\(error.localizedDescription)") }
  }

  /// The URL of the data to cache in the device memory.
  /// - Parameter name: The name of the data to cache used at its id.
  /// - Returns: The URL directory where the data is cached.
  private func cacheURL(for name: String) -> URL {
    cacheDirectory.appendingPathComponent(name)
  }
}

// MARK: - File Management
extension ImageCacheService {

  func write(_ data: Data, name: String) throws {
    let cacheName = NSString(string: name)
    inMemoryCache.setObject(NSData(data: data), forKey: cacheName)
    try data.write(to: cacheURL(for: name), options: .atomic)
    Task(priority: .background) { try await cleanMemorySurplus() }
  }

  func read(name: String) throws -> Data {
    let cacheName = NSString(string: name)
    if let cachedData = inMemoryCache.object(forKey: cacheName) {
      return Data(referencing: cachedData)
    } else {
      let data = try Data(contentsOf: cacheURL(for: name))
      inMemoryCache.setObject(NSData(data: data), forKey: cacheName)
      return data
    }
  }

  /// Removes a file with the specified name from disk storage.
  /// - Parameter name: The name of the saved data.
  private func remove(name: String) throws {
    try fileManager.removeItem(at: cacheURL(for: name))
  }
}

// MARK: - Memory Management
extension ImageCacheService {

  /// Deletes files until the total size is within the desired limit, starting from the
  /// oldest accessed files.
  private func cleanMemorySurplus() async throws {

    let files = try persistedFilesWithAttributes()
    let currentUsage = files.reduce(.zero) { $0 + $1.size }

    guard currentUsage > memoryLimit else { return }

    var accumulatedSize: Int = .zero
    var filesToDelete: [URL] = []
    let targetUsage = memoryLimit / 2

    for file in files.sorted(by: { $0.lastAccessed < $1.lastAccessed }) {
      accumulatedSize += file.size
      filesToDelete.append(file.url)

      if accumulatedSize >= currentUsage - targetUsage {
        break
      }
    }
    try filesToDelete.forEach { try fileManager.removeItem(at: $0) }
  }

  /// Retrieves a list of files with their last accessed date and size.
  /// - Returns: An array of tuples containing the URL, last accessed date, and size of each file.
  private func persistedFilesWithAttributes() throws -> SavedImageInfo {
    return try fileManager
      .contentsOfDirectory(
        at: cacheDirectory,
        includingPropertiesForKeys: [.contentAccessDateKey, .totalFileAllocatedSizeKey],
        options: []
      )
      .map { url in
        let attributes = try url
          .resourceValues(forKeys: [.contentAccessDateKey, .totalFileAllocatedSizeKey])

        return (
          url: url,
          lastAccessed: attributes.contentAccessDate ?? Date.distantPast,
          size: attributes.totalFileAllocatedSize ?? .zero
        )
      }
  }
}
