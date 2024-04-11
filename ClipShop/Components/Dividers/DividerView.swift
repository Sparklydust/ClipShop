//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// Divider view to be presented within view controllers.
final class DividerView: UIScrollView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setupDividerView()
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  /// Setup the scroll view attributes.
  private func setupDividerView() {
    translatesAutoresizingMaskIntoConstraints = false
    heightAnchor.constraint(equalToConstant: 1).isActive = true
    backgroundColor = .systemGray2
  }
}
