//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit
@testable import ClipShop

final class CoordinatorMock: CoordinatorProtocol {

  // Mock values
  var viewControllerStub: UIViewController?

  @MainActor init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  // Protocol requirements
  var navigationController: UINavigationController

  func start() {
    guard let viewControllerStub else { return }
    navigationController.pushViewController(viewControllerStub, animated: false)
  }
}
