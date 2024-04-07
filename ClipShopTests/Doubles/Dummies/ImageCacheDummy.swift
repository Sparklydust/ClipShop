//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation
@testable import ClipShop

final class ImageCacheDummy: ImageCacheProtocol {

  // Protocol requirements
  func write(_ data: Data, name: String) async throws {
    throw ImageCacheError.dataNotFound
  }

  func read(name: String) async throws -> Data {
    throw ImageCacheError.dataNotFound
  }
}
