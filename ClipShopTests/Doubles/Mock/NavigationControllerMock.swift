//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// Simulates the behavior of a ``UINavigationController`` being pushed for testing purposes.
final class NavigationControllerMock: UINavigationController {

  // Protocol requirements
  override func pushViewController(
    _ viewController: UIViewController,
    animated: Bool
  ) {
    super.pushViewController(viewController, animated: false)
  }
}
