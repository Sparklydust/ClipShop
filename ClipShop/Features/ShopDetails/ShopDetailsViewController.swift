//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// The view that populates details of a paperclip that can be purchased by users.
final class ShopDetailsViewController: UIViewController {

  private(set) var scrollView = MainScrollView()

  // MARK: - Models
  private var viewModel: ShopDetailsViewModel
  private var paperclip: PaperclipModel

  init(
    viewModel: ShopDetailsViewModel,
    paperclip: PaperclipModel
  ) {
    self.viewModel = viewModel
    self.paperclip = paperclip
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

// MARK: - View Components Constraints
extension ShopDetailsViewController {

  /// Sets up the view with the paperclip details.
  private func setupViewController() {
    view.backgroundColor = .systemBackground
    title = paperclip.category.name

    view.addSubview(scrollView)

    scrollViewConstraints()
  }

  private func scrollViewConstraints() {
    let layoutMargins = view.layoutMarginsGuide
    scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    scrollView.topAnchor.constraint(equalTo: layoutMargins.topAnchor).isActive = true
    scrollView.bottomAnchor.constraint(equalTo: layoutMargins.bottomAnchor).isActive = true
  }
}
