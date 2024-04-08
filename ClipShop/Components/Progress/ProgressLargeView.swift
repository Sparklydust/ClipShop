//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// Large progress view to be presented on views when items are loading from the server.
final class ProgressLargeView: UIActivityIndicatorView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setupProgress()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  /// Setup the progress attributes.
  private func setupProgress() {
    translatesAutoresizingMaskIntoConstraints = false
    style = .large
    color = .accent
  }
}
