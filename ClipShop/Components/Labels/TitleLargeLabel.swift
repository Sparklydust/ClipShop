//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// Large title label to be presented on details views to showcase an item title.
final class TitleLargeLabel: UILabel {

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
    ? .preferredFont(forTextStyle: .largeTitle)
    : .preferredFont(forTextStyle: .title1)
    numberOfLines = .zero
  }
}
