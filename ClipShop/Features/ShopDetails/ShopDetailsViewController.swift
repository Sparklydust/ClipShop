//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Combine
import UIKit

/// The view that populates details of a paperclip that can be purchased by users.
final class ShopDetailsViewController: UIViewController {

  var cancellables = Set<AnyCancellable>()
  private let isRegular = UIDevice.current.userInterfaceIdiom == .pad

  private(set) var descriptionLabel = DescriptionLabel()
  private(set) var imageLargeView = ImageLargeView(frame: .zero)
  private(set) var redactedView = RedactedView()
  private(set) var scrollView = MainScrollView()
  private(set) var titleLargeLabel = TitleLargeLabel()

  private(set) var siretLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = .zero
    label.font = .preferredFont(forTextStyle: .body)
    return label
  }()

  private(set) var priceLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = .zero
    label.font = .preferredFont(forTextStyle: .body)
    return label
  }()

  private(set) var dateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = .zero
    label.font = .preferredFont(forTextStyle: .body)
    return label
  }()

  private(set) var iconView: UIImageView = {
    let icon = UIImageView()
    icon.translatesAutoresizingMaskIntoConstraints = false
    return icon
  }()

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
    redactedView.layer.cornerRadius = .zero
  }
}

// MARK: - Constraints
extension ShopDetailsViewController {

  /// Sets up the view with the paperclip details.
  private func setupViewController() {
    view.backgroundColor = .systemBackground
    title = paperclip.category.name

    addSubviews()
    activateConstraints()
  }

  private func addSubviews() {
    view.addSubview(scrollView)
    scrollView.addSubview(imageLargeView)
    scrollView.addSubview(redactedView)
  }

  private func activateConstraints() {
    scrollViewConstraints()
    imageLargeViewConstraints()
    redactedViewConstraints()
  }

  private func scrollViewConstraints() {
    let layoutMargins = view.layoutMarginsGuide
    NSLayoutConstraint.activate([
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.topAnchor.constraint(equalTo: layoutMargins.topAnchor),
      scrollView.bottomAnchor.constraint(equalTo: layoutMargins.bottomAnchor)
    ])
  }

  private func imageLargeViewConstraints() {
    NSLayoutConstraint.activate([
      imageLargeView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
      imageLargeView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
      imageLargeView.trailingAnchor.constraint(lessThanOrEqualTo: scrollView.contentLayoutGuide.trailingAnchor),
      imageLargeView.widthAnchor.constraint(
        equalTo: scrollView.frameLayoutGuide.widthAnchor, multiplier: isRegular ? 0.33 : 1
      ),
      imageLargeView.heightAnchor.constraint(equalToConstant: isRegular ? 400 : 320),
    ])
  }

  private func redactedViewConstraints() {
    NSLayoutConstraint.activate([
      redactedView.topAnchor.constraint(equalTo: imageLargeView.topAnchor),
      redactedView.leadingAnchor.constraint(equalTo: imageLargeView.leadingAnchor),
      redactedView.widthAnchor.constraint(equalTo: imageLargeView.widthAnchor),
      redactedView.heightAnchor.constraint(equalTo: imageLargeView.heightAnchor)
    ])
  }
}
