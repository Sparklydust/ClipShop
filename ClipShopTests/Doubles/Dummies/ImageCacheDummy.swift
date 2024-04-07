//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation
@testable import ClipShop

final class ImageCacheDummy: ImageCacheProtocol {

  // Protocol requirements
  func write(_ data: Data, name: String) throws {
    // Intentionally empty
  }

  func read(name: String) throws -> Data {
    Data()
  }
}
