//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// Description label to be presented on cells to showcase an item description.
final class DescriptionLabel: UILabel {

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setupLabel()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    fatalError("init(coder:) has not been implemented")
  }

  /// Setup the label attributes.
  private func setupLabel() {
    translatesAutoresizingMaskIntoConstraints = false
    textAlignment = .left
    font = .preferredFont(forTextStyle: .body)
    numberOfLines = .zero
  }
}
