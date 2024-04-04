//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// Separate ``AppDelegate`` to avoid running tests on its instance.
@objc(AppDelegateTests)
class AppDelegateTests: UIResponder, UIApplicationDelegate {

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
    [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Intentionally empty
    return true
  }
}
