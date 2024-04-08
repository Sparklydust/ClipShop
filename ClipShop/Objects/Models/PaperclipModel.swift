//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// Paperclip item value for the shop initialized with server data to be presented
/// on views to users.
struct PaperclipModel {

  let id: Int
  let imageURL: (small: String?, thumb: String?)
  var image: UIImage? = .none
  let title: String
  let price: Decimal
  let category: CategoryModel
  let isUrgent: Bool

  init(
    with data: (paperclip: PaperclipData, categories: [CategoryData])
  ) {
    id = data.paperclip.id
    imageURL = (small: data.paperclip.imageURLs.small, thumb: data.paperclip.imageURLs.thumb)
    title = data.paperclip.title
    price = data.paperclip.price
    isUrgent = data.paperclip.isUrgent

    let categoryData = data.categories
      .first(where: { $0.id == data.paperclip.categoryID }) ?? .init(id: .zero, name: "Inconnu")
    category = CategoryModel(with: categoryData)
  }
}

// MARK: - Equatable
extension PaperclipModel: Equatable {

  static func == (lhs: PaperclipModel, rhs: PaperclipModel) -> Bool {
    lhs.id == rhs.id &&
    lhs.imageURL.small == rhs.imageURL.small &&
    lhs.imageURL.thumb == rhs.imageURL.thumb
  }
}
