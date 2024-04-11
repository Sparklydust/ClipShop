//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation

/// Enumeration of all the application's URL endpoints.
/// - Note: Opted for manual URL validation over unwrapping to prioritize simplicity in the
/// assessment context. This choice is deliberate, considering the controlled environment and
/// specific use case.
@frozen enum ServerEndpoint {

  case paperclipCategories
  case paperclipsList

  var url: URL {
    switch self {
    case .paperclipCategories: 
      URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json")!
    case .paperclipsList:
      URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json")!
    }
  }
}
