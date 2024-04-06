//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation
@testable import ClipShop

// Setup fake data for unit tests when initializing ``PaperclipData``.
extension PaperclipData {

  /// Create fake ``PaperclipData`` object for unit tests.
  /// Returns: Initialized object with fake data.
  static func fake(
    id: Int = 1701863618,
    categoryID: Int = 2,
    title: String = "Camion de Construction",
    description: String = "249 Pieces en métal, remise Metro Pelleport.",
    price: Decimal = 10.00,
    imageURLs: PaperclipData.ImageURLs = .fake(),
    creationDate: String = "2019-11-05T15:56:06+0000",
    isUrgent: Bool = true,
    siret: String? = "223 934 438"
  ) -> PaperclipData {
    .init(
      id: id,
      categoryID: categoryID,
      title: title,
      description: description,
      price: price,
      imageURLs: imageURLs,
      creationDate: creationDate,
      isUrgent: isUrgent,
      siret: siret
    )
  }
}

// Setup fake data for unit tests when initializing ``PaperclipData.ImageURLs``.
extension PaperclipData.ImageURLs {

  /// Create fake ``PaperclipData.ImageURLs`` object for unit tests.
  /// Returns: Initialized object with fake data.
  static func fake(
    small: String? = "https://raw.githubusercontent.com/paperclip/small/48b3e3cc.jpg",
    thumb: String? = "https://raw.githubusercontent.com/paperclip/thumb/48b3e3cc.jpg"
  ) -> PaperclipData.ImageURLs {
    .init(
      small: small,
      thumb: thumb
    )
  }
}
