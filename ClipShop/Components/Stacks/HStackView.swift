//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// Stack view to be used within scroll views using a horizontal axis.
final class HStackView: UIStackView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setupStackView()
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  /// Setup the stack view attributes.
  private func setupStackView() {
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .clear
    axis = .horizontal
  }
}
