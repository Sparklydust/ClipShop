//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation
@testable import ClipShop

// Setup fake data for unit tests when initializing ``CategoryModel``.
extension CategoryModel {

  /// Create fake ``CategoryModel`` object for unit tests.
  /// Returns: Initialized object with fake data.
  static func fake(
    with data: CategoryData = .fake()
  ) -> CategoryModel {
    .init(with: data)
  }
}
