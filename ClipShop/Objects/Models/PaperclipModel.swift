//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation

/// Paperclip item value for the shop initialized with server data to be presented
/// on views to users.
struct PaperclipModel: Equatable {

  let id: Int

  init(with data: PaperclipData) {
    id = data.id
  }
}
