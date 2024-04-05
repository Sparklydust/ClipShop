//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation

/// Enumeration of the listed .json files representing the data objects.
///
/// All data objects are the request contract of the ClipShop server.
@frozen enum JsonFileName: String {

  case categoryData = "CategoryData"
  /// Used to trigger errors during ``URLSessionMock`` response.
  case errorData = "" // Empty value is expected for an error.
  case paperclipData = "PaperclipData"
}
