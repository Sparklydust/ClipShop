//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation

/// Responsible of handling the logic of the ``ShopListViewController``.
final class ShopListViewModel {

  @Published var isLoading = false

  private var server: ServerProtocol

  init(server: ServerProtocol = ServerService()) {
    self.server = server
  }
}

// MARK: - ServerService
extension ShopListViewModel {

  func getPaperclipsList() async {
    isLoading = true
    defer { isLoading = false }
  }
}
