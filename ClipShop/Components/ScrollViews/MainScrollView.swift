//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// Scroll view to be presented within the ``ShopDetailsViewController``.
final class MainScrollView: UIScrollView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setupScrollView()
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  /// Setup the scroll view attributes.
  private func setupScrollView() {
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .clear
  }
}
