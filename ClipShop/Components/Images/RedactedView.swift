//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// Redacted view to showcase a loading or empty image to be displayed to the user.
final class RedactedView: UIView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setupView()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    fatalError("init(coder:) has not been implemented")
  }

  /// Setup the redacted view attributes.
  private func setupView() {
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .systemGray4
    layer.cornerRadius = 8
  }
}
