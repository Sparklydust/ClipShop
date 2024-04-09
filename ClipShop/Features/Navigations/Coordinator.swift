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
    viewController.delegate = self
    navigationController.pushViewController(viewController, animated: true)
  }
  
  /// Trigger the navigation to the ``ShopDetailsViewController`` to see all informations about a
  /// `paperclip`.
  /// - Parameter paperclip: The selected item from the shop list.
  private func showDetails(for paperclip: PaperclipModel) {
    let shopDetailsVC = ShopDetailsViewController(paperclip: paperclip)
    navigationController.pushViewController(shopDetailsVC, animated: true)
  }
}

// MARK: - ShopListViewControllerDelegate
extension Coordinator: ShopListViewControllerDelegate {

  func didSelectItem(_ paperclip: PaperclipModel) {
    showDetails(for: paperclip)
  }
}
