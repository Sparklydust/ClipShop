//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Combine
import UIKit

/// The view that populates details of a paperclip that can be purchased by users.
final class ShopDetailsViewController: UIViewController {

  var cancellables = Set<AnyCancellable>()
  private let isRegular = UIDevice.current.userInterfaceIdiom == .pad

  private(set) var dateLabel = DateLabel()
  private(set) var descriptionLabel = DescriptionLabel()
  private(set) var imageView = ImageView(size: .large)
  private(set) var redactedView = RedactedView()
  private(set) var scrollView = MainScrollView()
  private(set) var priceLabel = PriceLabel(size: .large)
  private(set) var siretLabel = SiretLabel()
  private(set) var titleLabel = TitleLabel(size: .large)
  private(set) var urgentIcon = UrgentIcon(frame: .zero)

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
    configureLabels()
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
  private func imageConfiguration(with image: UIImage?) {
    imageView.image = image
    imageView.isHidden = image == .none
    redactedView.isHidden = image != .none
    redactedView.layer.cornerRadius = .zero
  }

  @MainActor private func configureLabels() {
    dateLabel.text = paperclip.creationDate.toString()
    descriptionLabel.text = paperclip.description
    priceLabel.text = "\(paperclip.price)€"
    siretLabel.text = paperclip.siret
    titleLabel.text = paperclip.title
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
    view.addSubview(urgentIcon)
    scrollView.addSubview(imageView)
    scrollView.addSubview(redactedView)
    scrollView.addSubview(dateLabel)
    scrollView.addSubview(descriptionLabel)
    scrollView.addSubview(priceLabel)
    scrollView.addSubview(siretLabel)
    scrollView.addSubview(titleLabel)
  }

  private func activateConstraints() {
    scrollViewConstraints()
    imageViewConstraints()
    redactedViewConstraints()
    urgentIconConstraints()
    dateLabelConstraints()
    descriptionLabelConstraints()
    priceLabelConstraints()
    siretLabelConstraints()
    titleLabelConstraints()
  }

  private func scrollViewConstraints() {
    let contentView = UIView()
    contentView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(contentView)

    let safeArea = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([      
      scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
      scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
      scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
      contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
      contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
      contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
      contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
    ])
  }

  private func imageViewConstraints() {
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
      imageView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
      imageView.trailingAnchor.constraint(lessThanOrEqualTo: scrollView.contentLayoutGuide.trailingAnchor),
      imageView.widthAnchor.constraint(
        equalTo: scrollView.frameLayoutGuide.widthAnchor, multiplier: isRegular ? 0.44 : 1
      ),
      imageView.heightAnchor.constraint(equalToConstant: isRegular ? 400 : 320),
    ])
  }

  private func redactedViewConstraints() {
    NSLayoutConstraint.activate([
      redactedView.topAnchor.constraint(equalTo: imageView.topAnchor),
      redactedView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
      redactedView.widthAnchor.constraint(equalTo: imageView.widthAnchor),
      redactedView.heightAnchor.constraint(equalTo: imageView.heightAnchor)
    ])
  }

  private func urgentIconConstraints() {
    NSLayoutConstraint.activate([
      urgentIcon.trailingAnchor.constraint(
        equalTo: view.trailingAnchor, constant: isRegular ? -8 : -4
      ),
      urgentIcon.topAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.topAnchor,
        constant: isRegular ? .zero : 4
      ),
      urgentIcon.widthAnchor.constraint(equalToConstant: isRegular ? 44 : 36),
      urgentIcon.heightAnchor.constraint(equalToConstant: isRegular ? 44 : 36)
    ])
  }

  private func dateLabelConstraints() {
    // Intentionally empty
  }

  private func descriptionLabelConstraints() {
    // Intentionally empty
  }

  private func priceLabelConstraints() {
    // Intentionally empty
  }

  private func siretLabelConstraints() {
    // Intentionally empty
  }

  private func titleLabelConstraints() {
    titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16)
      .isActive = isRegular ? false : true
    titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16)
      .isActive = isRegular ? true : false
    titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16)
      .isActive = isRegular ? false : true
    titleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16)
      .isActive = true
    titleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
      .isActive = isRegular ? true : false
  }
}
