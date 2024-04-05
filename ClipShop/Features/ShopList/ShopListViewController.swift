//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// The view that populates a list of paperclips that can be purchased by users.
class ShopListViewController: UIViewController {

  // MARK: - View Objects
  private(set) var activityIndicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(style: .large)
    indicator.translatesAutoresizingMaskIntoConstraints = false
    indicator.color = .accent
    return indicator
  }()

  private var viewModel: ShopListViewModel

  init(viewModel: ShopListViewModel = ShopListViewModel()) {
    self.viewModel = viewModel
    super.init(nibName: .none, bundle: .none)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewController()
  }
}

// MARK: - View Constraints
extension ShopListViewController {

  private func setupViewController() {
    view.backgroundColor = .systemBackground
    activityIndicatorConstraints()
  }

  private func activityIndicatorConstraints() {
    view.addSubview(activityIndicator)

    NSLayoutConstraint.activate([
      activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
}
