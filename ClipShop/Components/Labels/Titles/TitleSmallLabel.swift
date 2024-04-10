//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// Small title label to be presented on cells to showcase an item title.
final class TitleSmallLabel: UILabel {

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
    font = UIDevice.current.userInterfaceIdiom == .pad
    ? .preferredFont(forTextStyle: .title3, weight: .semibold)
    : .preferredFont(forTextStyle: .callout, weight: .medium)
    numberOfLines = 3
    allowsDefaultTighteningForTruncation = true
  }
}
