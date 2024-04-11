//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation

/// Data representing paperclip items to be populated within the app shopping views.
struct PaperclipData: Codable, Equatable {

  let id: Int
  let categoryID: Int
  let title: String
  let description: String
  let price: Decimal
  let imageURLs: ImageURLs
  let creationDate: String
  let isUrgent: Bool
  let siret: String? 

  enum CodingKeys: String, CodingKey {
    case id, title, description, price, siret
    case categoryID = "category_id"
    case imageURLs = "images_url"
    case creationDate = "creation_date"
    case isUrgent = "is_urgent"
  }

  struct ImageURLs: Codable, Equatable {

    let small: String?
    let thumb: String?
  }
}
