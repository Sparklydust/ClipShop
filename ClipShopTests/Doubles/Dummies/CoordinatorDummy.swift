//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit
@testable import ClipShop

final class CoordinatorDummy: CoordinatorProtocol {

  // Dummy values
  @MainActor init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  // Protocol requirements
  var navigationController: UINavigationController

  func start() {
    // Intentionally empty
  }
}
