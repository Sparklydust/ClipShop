//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation

/// Defining the delegate responsibilities for ``ShopListViewController``.
///
/// Allows for communication back to the coordinating object or parent view controller when
/// specific actions are taken within the ``ShopListViewController``.
protocol ShopListViewControllerDelegate: AnyObject {

  /// Notifies the delegate when an item within the shop list is selected to be presented on
  /// the ``ShopDetailsViewController``.
  /// - Parameter paperclip: The ``PaperclipModel`` representing the item that was selected.
  func didSelectItem(_ paperclip: PaperclipModel)
}
