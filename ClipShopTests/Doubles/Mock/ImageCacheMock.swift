//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation
@testable import ClipShop

final class ImageCacheMock: ImageCacheProtocol {

  var writtenDataStub = [String: Data]()
  var dataStub: Data?
  var errorStub: Error?

  // Protocol requirements
  func write(_ data: Data, name: String) async throws {
    guard errorStub == nil else { throw errorStub! }
    writtenDataStub[name] = data
  }

  func read(name: String) async throws -> Data {
    guard errorStub == nil, let dataStub
    else { throw errorStub ?? ImageCacheError.dataNotFound }
    return dataStub
  }
}
