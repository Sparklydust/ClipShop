//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// Date label to be presented on details view to showcase an item creation date.
final class DateLabel: UILabel {

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
    font = UIDevice.current.userInterfaceIdiom == .pad
    ? .preferredFont(forTextStyle: .callout)
    : .preferredFont(forTextStyle: .footnote)
  }
}
