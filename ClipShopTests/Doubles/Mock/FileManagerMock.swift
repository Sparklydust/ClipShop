//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation
@testable import ClipShop

final class FileManagerMock: FileManagerProtocol {

  // Mock values
  var urlsStub = [URL]()
  var createDirectoryErrorStub: Error?
  var removeItemErrorStub: Error?
  var contentsOfDirectoryStub: [URL] = []

  // Protocol Requirements
  func urls(
    for directory: FileManager.SearchPathDirectory,
    in domainMask: FileManager.SearchPathDomainMask
  ) -> [URL] {
    urlsStub
  }
  
  func createDirectory(
    at url: URL,
    withIntermediateDirectories createIntermediates: Bool,
    attributes: [FileAttributeKey : Any]?
  ) throws {
    guard createDirectoryErrorStub == nil else { throw createDirectoryErrorStub! }
  }
  
  func removeItem(at URL: URL) throws {
    guard removeItemErrorStub == nil else { throw removeItemErrorStub! }
  }

  func contentsOfDirectory(
    at url: URL,
    includingPropertiesForKeys keys: [URLResourceKey]?,
    options mask: FileManager.DirectoryEnumerationOptions
  ) throws -> [URL] {
    contentsOfDirectoryStub
  }
}
