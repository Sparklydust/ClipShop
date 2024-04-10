//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// Small title label to be presented on cells to showcase an item title.
final class TitleLabel: UILabel {

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
    numberOfLines = size == .small ? 3 : .zero
    allowsDefaultTighteningForTruncation = true
    setupFont()
  }

  private func setupFont() {
    switch size {
    case .small:
      font = UIDevice.current.userInterfaceIdiom == .pad
      ? .preferredFont(forTextStyle: .title3, weight: .semibold)
      : .preferredFont(forTextStyle: .callout, weight: .medium)
    case .large:
      font = UIDevice.current.userInterfaceIdiom == .pad
      ? .preferredFont(forTextStyle: .largeTitle)
      : .preferredFont(forTextStyle: .title1)
    }
  }
}
