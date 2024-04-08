//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation

/// The object referring to ``PaperclipModel`` object shop categories.
struct CategoryModel: Equatable {

  let id: Int
  let name: String

  init(with data: CategoryData) {
    id = data.id
    name = data.name
  }
}
