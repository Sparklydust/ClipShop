//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// Responsible of handling the logic of the ``ShopDetailsViewController``.
final class ShopDetailsViewModel {

  @Published var itemImage: UIImage?

  private var server: ServerProtocol

  init(server: ServerProtocol = ServerService()) {
    self.server = server
  }
}

// MARK: - ServerService
extension ShopDetailsViewModel {

  /// Asynchronously loads an image from a specified URL.
  /// - Parameter paperclip: The paperclip item to get the image's URL string to be loaded.
  @MainActor func loadImage(for paperclip: PaperclipModel) async {
    guard let urlString = paperclip.imageURL.thumb else { return }
    itemImage = await server.loadImage(urlString: urlString)
  }
}
