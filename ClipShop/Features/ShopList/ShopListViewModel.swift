//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation

/// Responsible of handling the logic of the ``ShopListViewController``.
final class ShopListViewModel {

  @Published var isLoading = false
  @Published var paperclips = [PaperclipModel]()

  private var server: ServerProtocol

  init(server: ServerProtocol = ServerService()) {
    self.server = server
  }
}

// MARK: - ServerService
extension ShopListViewModel {

  @MainActor func getPaperclipsList() async {
    isLoading = true
    defer { isLoading = false }

    do {
      let data = try await server.get([PaperclipData].self, atEndpoint: .paperclipsList)
      paperclips = data.map { PaperclipModel(with: $0) }
    } catch {
      // Intentionally empty
    }
  }
}
