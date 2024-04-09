//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// Coordinate the navigations flows between views within the application.
final class Coordinator: CoordinatorProtocol {

  var navigationController: UINavigationController
  var shopListViewModel: ShopListViewModel

  init(
    navigationController: UINavigationController,
    shopListViewModel: ShopListViewModel = ShopListViewModel()
  ) {
    self.navigationController = navigationController
    self.shopListViewModel = shopListViewModel
  }
}

// MARK: - Navigations
extension Coordinator {

  func start() {
    let viewController = ShopListViewController(viewModel: shopListViewModel)
    navigationController.pushViewController(viewController, animated: true)
  }
}
