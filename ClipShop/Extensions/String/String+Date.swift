//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation

extension String {

  /// Unwrap the date in ``String`` from the server into a ISO8601 ``Date`` format.
  /// - Returns: An unwrap date value.
  func iso8601Date() -> Date {
    let formatter = ISO8601DateFormatter()
    guard let date = formatter.date(from: self)
    else { return Date() }
    return date
  }
}
