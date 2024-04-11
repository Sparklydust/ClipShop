//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation

extension Date {
  
  /// Convert a date to a user readable string.
  /// - Returns: A full date to be read.
  func toString() -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .full
    formatter.locale = .init(identifier: "fr-FR")
    return formatter.string(from: self)
  }
}
