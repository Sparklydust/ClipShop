//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Combine
import UIKit

/// The view that populates details of a paperclip that can be purchased by users.
final class ShopDetailsViewController: UIViewController {

  var cancellables = Set<AnyCancellable>()
  private let isRegular = UIDevice.current.userInterfaceIdiom == .pad
  private var mainPadding: CGFloat { isRegular ? 16 : 8 }

  private(set) var dateLabel = DateLabel()
  private(set) var descriptionLabel = DescriptionLabel()
  private(set) var imageView = ImageView(size: .large)
  private(set) var redactedView = RedactedView()
  private(set) var scrollView = MainScrollView()
  private(set) var priceLabel = PriceLabel(size: .large)
  private(set) var siretLabel = SiretLabel()
  private(set) var titleLabel = TitleLabel(size: .large)
  private(set) var urgentIcon = UrgentIcon(frame: .zero)
  private(set) var divider1 = DividerView()
  private(set) var divider2 = DividerView()

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
    dateLabel.text = "Publié le \(paperclip.creationDate.toString())"
    descriptionLabel.text = paperclip.description
    priceLabel.text = "\(paperclip.price)€"
    siretLabel.text = "SIRET: \(paperclip.siret)"
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
    scrollView.addSubview(urgentIcon)
    scrollView.addSubview(imageView)
    scrollView.addSubview(redactedView)
    scrollView.addSubview(dateLabel)
    scrollView.addSubview(descriptionLabel)
    scrollView.addSubview(priceLabel)
    scrollView.addSubview(siretLabel)
    scrollView.addSubview(titleLabel)
    scrollView.addSubview(divider1)
    scrollView.addSubview(divider2)
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
    divider1Constraints()
    divider2Constraints()
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
    urgentIcon.isHidden = !paperclip.isUrgent
    urgentIcon.widthAnchor.constraint(equalToConstant: isRegular ? 36 : 24).isActive = true
    urgentIcon.heightAnchor.constraint(equalToConstant: isRegular ? 36 : 24).isActive = true
    urgentIcon.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: mainPadding)
      .isActive = paperclip.isUrgent
    urgentIcon.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor).isActive = true
  }

  private func dateLabelConstraints() {
    dateLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16)
      .isActive = isRegular ? true : false
    dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8)
      .isActive = isRegular ? false : true
    dateLabel.leadingAnchor.constraint(
      equalTo: paperclip.isUrgent ? urgentIcon.trailingAnchor : scrollView.leadingAnchor,
      constant: paperclip.isUrgent ? isRegular ? 8 : 4 : mainPadding)
      .isActive = true
  }

  private func descriptionLabelConstraints() {
    descriptionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: mainPadding * 2)
      .isActive = true
    descriptionLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -mainPadding * 2)
      .isActive = true
    descriptionLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -mainPadding)
      .isActive = true
  }

  private func priceLabelConstraints() {
    priceLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: mainPadding * 2)
      .isActive = true
  }

  private func siretLabelConstraints() {
    siretLabel.isHidden = paperclip.siret.isEmpty
    siretLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: mainPadding)
      .isActive = !paperclip.siret.isEmpty
    siretLabel.bottomAnchor.constraint(equalTo: divider2.topAnchor, constant: -(mainPadding * 2))
      .isActive = !paperclip.siret.isEmpty
    siretLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor)
      .isActive = !paperclip.siret.isEmpty
  }

  private func titleLabelConstraints() {
    titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16)
      .isActive = isRegular ? false : true
    titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: mainPadding)
      .isActive = isRegular ? true : false
    titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: mainPadding)
      .isActive = isRegular ? false : true
    titleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -mainPadding)
      .isActive = true
    titleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
      .isActive = isRegular ? true : false
  }

  private func divider1Constraints() {
    divider1.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: mainPadding * 1.5)
      .isActive = true
    divider1.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: -(mainPadding * 1.5))
      .isActive = true
    divider1.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
  }

  private func divider2Constraints() {
    divider2.topAnchor.constraint(
      equalTo: priceLabel.bottomAnchor,
      constant: mainPadding * 1.5
    ).isActive = paperclip.siret.isEmpty ? true : false
    divider2.bottomAnchor.constraint(
      equalTo: descriptionLabel.topAnchor,
      constant: -(mainPadding * 2)
    ).isActive = true
    divider2.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
  }
}
