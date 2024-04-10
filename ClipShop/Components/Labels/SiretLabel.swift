//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// SIRET label to be presented on a view to showcase an item company linked number.
final class SiretLabel: UILabel {

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
    font = .preferredFont(forTextStyle: .caption1)
    numberOfLines = 1
  }
}
