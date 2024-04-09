//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  var coordinator: Coordinator?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let scene = (scene as? UIWindowScene) else { return }
    let navigationController = UINavigationController()

    coordinator = Coordinator(navigationController: navigationController)
    coordinator?.start()

    window = UIWindow(windowScene: scene)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }
}
