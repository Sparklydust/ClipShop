//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation

/// Responsible of handling the logic of the ``ShopListViewController``.
final class ShopListViewModel {

  private var server: ServerProtocol

  init(server: ServerProtocol = ServerService()) {
    self.server = server
  }
}
