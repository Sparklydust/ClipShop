//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// Coordinate the navigations flows between views within the application.
final class Coordinator: CoordinatorProtocol {

  var navigationController: UINavigationController
  var shopListViewModel: ShopListViewModel?
  var shopDetailsViewModel: ShopDetailsViewModel?

  /// - Warning: View models injection is used for unit tests only to inject mocks.
  init(
    navigationController: UINavigationController,
    shopDetailsViewModel: ShopDetailsViewModel? = .none,
    shopListViewModel: ShopListViewModel? = .none
  ) {
    self.navigationController = navigationController
    self.shopDetailsViewModel = shopDetailsViewModel
    self.shopListViewModel = shopListViewModel
  }
}

// MARK: - Navigations
extension Coordinator {

  func start() {
    let viewModel = shopListViewModel == nil ? ShopListViewModel() : shopListViewModel!
    let viewController = ShopListViewController(viewModel: viewModel)
    viewController.delegate = self
    navigationController.pushViewController(viewController, animated: true)
  }

  /// Trigger the navigation to the ``ShopDetailsViewController`` to see all informations about a
  /// `paperclip`.
  /// - Parameter paperclip: The selected item from the shop list.
  private func showDetails(for paperclip: PaperclipModel) {
    let viewModel = shopDetailsViewModel == nil ? ShopDetailsViewModel() : shopDetailsViewModel!
    let shopDetailsVC = ShopDetailsViewController(
      viewModel: viewModel,
      paperclip: paperclip
    )
    navigationController.pushViewController(shopDetailsVC, animated: true)
  }
}

// MARK: - ShopListViewControllerDelegate
extension Coordinator: ShopListViewControllerDelegate {

  func didSelectItem(_ paperclip: PaperclipModel) {
    showDetails(for: paperclip)
  }
}
