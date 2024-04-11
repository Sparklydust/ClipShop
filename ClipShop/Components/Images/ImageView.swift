//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// Small image view to be presented on cells to showcase an item.
final class ImageView: UIImageView {

  private let size: ComponentSize

  init(size: ComponentSize) {
    self.size = size
    super.init(frame: .zero)
    self.setupImage()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  /// Setup the image attributes.
  private func setupImage() {
    translatesAutoresizingMaskIntoConstraints = false
    contentMode = .scaleAspectFill
    layer.cornerRadius = size == .small ? 8 : .zero
    clipsToBounds = true
  }
}
