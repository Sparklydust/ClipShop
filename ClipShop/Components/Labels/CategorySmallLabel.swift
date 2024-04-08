//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// Small secondary label to be presented on cells to showcase an item category.
final class CategorySmallLabel: UILabel {

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
    ? .preferredFont(forTextStyle: .footnote)
    : .preferredFont(forTextStyle: .caption1)
    textColor = .secondaryLabel
  }
}
