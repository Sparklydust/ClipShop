//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

let appDelegate: AnyClass = NSClassFromString("AppDelegateTests") ?? AppDelegate.self
UIApplicationMain(
  CommandLine.argc,
  CommandLine.unsafeArgv,
  .none,
  NSStringFromClass(appDelegate)
)
