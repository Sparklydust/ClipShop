//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// Icon view to be presented on views to showcase an item's urgent status.
final class UrgentIcon: UIImageView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setupIcon()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    fatalError("init(coder:) has not been implemented")
  }

  /// Setup the icon attributes.
  private func setupIcon() {
    translatesAutoresizingMaskIntoConstraints = false
    contentMode = .scaleAspectFit
    image = UIImage(systemName: "eurosign.arrow.circlepath")
    tintColor = .accent
  }
}
