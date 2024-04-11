//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation
@testable import ClipShop

// Setup fake data for unit tests when initializing ``CategoryData``.
extension CategoryData {

  /// Create fake ``CategoryData`` object for unit tests.
  /// Returns: Initialized object with fake data.
  static func fake(
    id: Int = 2,
    name: String = "Mode"
  ) -> CategoryData {
    .init(
      id: id,
      name: name
    )
  }
}
