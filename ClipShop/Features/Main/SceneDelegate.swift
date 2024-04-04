//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let scene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: scene)
    let nav = UINavigationController(rootViewController: ViewController())
    window?.rootViewController = nav
    window?.makeKeyAndVisible()
  }
}
