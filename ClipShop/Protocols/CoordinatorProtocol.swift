//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// A protocol that defines the basic structure and functionality of navigations between views.
///
/// Coordinators are responsible for navigation and flow control within the app, decoupling 
/// these responsibilities from view controllers.
protocol CoordinatorProtocol {

  /// The navigation controller used by the coordinator to manage the app's navigation stack.
  ///
  /// This property should be set by the adopting coordinator to control the navigation flow.
  var navigationController: UINavigationController { get set }

  /// Starts the coordination process.
  ///
  /// This method should be implemented by the adopting coordinator to configure and display
  /// the initial view controller, or to perform any setup required before navigation begins.
  func start()
}
