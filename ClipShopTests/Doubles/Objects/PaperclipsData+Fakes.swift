//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation
@testable import ClipShop

// Setup fake data for unit tests when initializing ``PaperclipData``.

extension PaperclipData {

  /// Create fake ``PaperclipData`` object for unit tests.
  /// Returns: Initialized object with fake data.
  static func fake() -> PaperclipData {
    .init()
  }
}
