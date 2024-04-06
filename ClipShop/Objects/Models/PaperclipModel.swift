//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// Paperclip item value for the shop initialized with server data to be presented
/// on views to users.
struct PaperclipModel: Equatable {

  let id: Int
  var image: UIImage? = .none
  let title: String
  let price: Decimal
  let category: String

  init(with data: (paperclip: PaperclipData, categories: [CategoryData])) {
    id = data.paperclip.id
    title = data.paperclip.title
    price = data.paperclip.price
    category = data.categories
      .first { $0.id == data.paperclip.categoryID }?
      .name ?? "Unknown Category"
  }
}
