//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

extension UIFont {

  /// Returns a font object that is appropriately scaled on text size and specified weight.
  /// - Parameters:
  ///   - style: The text style for which the font is intended.
  ///   - weight: The weight (thickness) of the font's strokes.
  /// - Returns: A ``UIFont`` object that is scaled accordingly to passed parameters.
  static func preferredFont(
    forTextStyle style: TextStyle,
    weight: Weight
  ) -> UIFont {

    let traits = UITraitCollection(preferredContentSizeCategory: .large)
    let desc = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style, compatibleWith: traits)
    var font = UIFont.systemFont(ofSize: desc.pointSize, weight: weight)
    let metrics = UIFontMetrics(forTextStyle: style)

    return metrics.scaledFont(for: font)
  }
}
