//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

extension UIAlertController {

  /// Alert to be presented on a server error.
  static var serverErrorAlert: UIAlertController = {
    let alert = UIAlertController(
      title: "Server Error",
      message: "Connect to the world wide web and restart ClipShop.",
      preferredStyle: .alert
    )
    alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
    alert.view.tintColor = .accent
    return alert
  }()
}
