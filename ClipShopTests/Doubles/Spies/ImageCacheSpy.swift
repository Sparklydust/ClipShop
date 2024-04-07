//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation
@testable import ClipShop

final class ImageCacheSpy: ImageCacheProtocol {

  // Spy value
  var isWriteCalled = false
  var isReadCalled = false
  var data: Data?
  var name: String?

  // Protocol requirements
  func write(_ data: Data, name: String) throws {
    isWriteCalled = true
    self.data = data
    self.name = name
  }

  func read(name: String) throws -> Data {
    isReadCalled = true
    self.name = name
    return Data()
  }
}
