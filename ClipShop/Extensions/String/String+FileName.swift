//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation

extension String {

  /// Define a file name from a URL to be used within ``FileManager``.
  var extractedFileName: String {
    let baseUrl = self.components(separatedBy: "?").first ?? self
    let pathComponents = baseUrl.components(separatedBy: "/")
    guard pathComponents.count > 2
    else { return baseUrl.components(separatedBy: "/").last ?? String() }

    let sizeComponent = pathComponents[pathComponents.count - 2]
    let nameComponent = pathComponents.last ?? String()
    return sizeComponent + "-" + nameComponent
  }
}
