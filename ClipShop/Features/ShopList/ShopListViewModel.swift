//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// Responsible of handling the logic of the ``ShopListViewController``.
final class ShopListViewModel {

  @Published var isLoading = false
  @Published var showError = false
  @Published var paperclips = [PaperclipModel]()
  @Published var categories = [CategoryModel]()

  private var server: ServerProtocol

  init(server: ServerProtocol = ServerService()) {
    self.server = server
  }
}

// MARK: - ServerService
extension ShopListViewModel {

  /// Get the paperclips data from the ClipShop server to be shown to users.
  @MainActor func getPaperclipsList() async {
    isLoading = true
    defer { isLoading = false }

    do {
      async let paperclipData = try await server.get([PaperclipData].self, atEndpoint: .paperclipsList)
      async let categoryData = try await server.get([CategoryData].self, atEndpoint: .paperclipCategories)

      let data = try await (paperclipData, categoryData)

      categories = data.1.map { CategoryModel(with: $0) }.sorted(by: { $0.name < $1.name })
      paperclips = data.0.map { PaperclipModel(with: ($0, data.1)) }
    } catch {
      showError = true
    }
  }

  /// Asynchronously loads an image from a specified URL.
  /// - Parameter urlString: The URL string of the image to be loaded.
  /// - Returns: The requested image or nil on failure.
  @MainActor func loadImage(urlString: String) async -> UIImage? {
    await server.loadImage(urlString: urlString)
  }
}
