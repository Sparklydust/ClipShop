//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// Capturing which view controllers are pushed onto the navigation stack of the ``Coordinator``.
class NavigationControllerSpy: UINavigationController {

  // Spy values
  var viewController: UIViewController?
  var animated: Bool?
  var isPushViewControllerCalled = false

  // Protocol requirements
  override func pushViewController(
    _ viewController: UIViewController,
    animated: Bool
  ) {
    isPushViewControllerCalled = true
    self.animated = animated
    self.viewController = viewController
  }
}
