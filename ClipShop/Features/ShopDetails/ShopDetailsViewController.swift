//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Combine
import UIKit

/// The view that populates details of a paperclip that can be purchased by users.
final class ShopDetailsViewController: UIViewController {

  var cancellables = Set<AnyCancellable>()

  private(set) var imageLargeView = ImageLargeView(frame: .zero)
  private(set) var redactedView = RedactedView()
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
    observeViewModelPipelines()
    Task { await viewModel.loadImage(for: paperclip) }
  }
}

// MARK: - Pipelines
extension ShopDetailsViewController {

  /// Listening to Combine pipelines from the `viewModel` observing its changes to update `view`.
  /// - Info: Reactive programming, making the UI responsive and dynamic.
  @MainActor private func observeViewModelPipelines() {
    viewModel.$itemImage
      .sink { [weak self] image in self?.imageConfiguration(with: image) }
      .store(in: &cancellables)
  }
}

// MARK: - Configurations
extension ShopDetailsViewController {

  /// Define the image to be populated on the view.
  /// - Parameter image: The image to be shown if any else, `redactedView` is presented.
  func imageConfiguration(with image: UIImage?) {
    imageLargeView.image = image
    imageLargeView.isHidden = image == .none
    redactedView.isHidden = image != .none
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
