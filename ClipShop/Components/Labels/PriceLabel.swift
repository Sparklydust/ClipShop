//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// Price label to be presented on cells to showcase an item price.
final class PriceLabel: UILabel {

  private let isRegular = UIDevice.current.userInterfaceIdiom == .pad

  private let size: ComponentSize

  init(size: ComponentSize) {
    self.size = size
    super.init(frame: .zero)
    self.setupLabel()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  /// Setup the label attributes.
  private func setupLabel() {
    translatesAutoresizingMaskIntoConstraints = false
    textAlignment = .left
    setupFont()
  }

  private func setupFont() {
    switch size {
    case .small:
      font = isRegular
      ? .preferredFont(forTextStyle: .headline)
      : .preferredFont(forTextStyle: .subheadline, weight: .medium)
    case .large:
      font = isRegular
      ? .preferredFont(forTextStyle: .title3)
      : .preferredFont(forTextStyle: .headline)
    }
  }
}
