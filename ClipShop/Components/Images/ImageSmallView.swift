//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// Small image view to be presented on cells to showcase an item.
final class ImageSmallView: UIImageView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setupImage()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    fatalError("init(coder:) has not been implemented")
  }

  /// Setup the image attributes.
  private func setupImage() {
    translatesAutoresizingMaskIntoConstraints = false
    contentMode = .scaleAspectFill
    layer.cornerRadius = 8
    clipsToBounds = true
  }
}
