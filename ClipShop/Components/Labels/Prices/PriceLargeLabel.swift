//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// Large price label to be presented on details views to showcase an item price.
final class PriceLargeLabel: UILabel {

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
    ? UIFont.preferredFont(forTextStyle: .title3)
    : .preferredFont(forTextStyle: .headline)
  }
}
