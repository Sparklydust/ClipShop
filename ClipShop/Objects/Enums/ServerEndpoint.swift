//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation

/// Enumeration of all the application's URL endpoints.
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
