//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// Small price label to be presented on cells to showcase an item price.
final class PriceSmallLabel: UILabel {

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
    ? .preferredFont(forTextStyle: .headline)
    : .preferredFont(forTextStyle: .subheadline, weight: .medium)
  }
}
