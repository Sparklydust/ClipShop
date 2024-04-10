//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// Cell component to populate ``PaperclipModel`` within the ``ShopListViewController`` within
/// a collection view cell.
final class PaperclipCell: UICollectionViewCell {

  static let reuseIdentifier = "PaperclipCell"
  private let isRegular = UIDevice.current.userInterfaceIdiom == .pad

  // MARK: - Components
  private(set) var categorySmallLabel = CategorySmallLabel()
  private(set) var priceLabel = PriceLabel(size: .small)
  private(set) var titleLabel = TitleLabel(size: .small)
  private(set) var imageSmallView = ImageSmallView(frame: .zero)
  private(set) var urgentIcon = UrgentIcon(frame: .zero)
  private(set) var redactedView = RedactedView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupCell()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Configurations
extension PaperclipCell {

  /// Define the cell values from the model passed in the parameter.
  /// - Parameter model: The ``PaperclipModel`` instance containing the data from the server
  /// adapted to be displayed on the cell.
  func configure(with model: PaperclipModel) {
    imageConfiguration(with: model.image)
    titleLabel.text = model.title
    priceLabel.text = "\(model.price)€"
    categorySmallLabel.text = model.category.name
    urgentIcon.isHidden = !model.isUrgent
  }

  /// Define the image to be populated on the cell.
  /// - Parameter image: The image to be shown if any else, `redactedView` is presented.
  func imageConfiguration(with image: UIImage?) {
    imageSmallView.image = image
    imageSmallView.isHidden = image == .none
    redactedView.isHidden = image != .none
  }
}

// MARK: - Setup
extension PaperclipCell {

  private func setupCell() {
    backgroundColor = .secondarySystemBackground
    defineLayers()
    addSubviews()
    activateConstraints()
  }

  private func defineLayers() {
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 2, height: 2)
    layer.shadowRadius = 4
    layer.shadowOpacity = 0.4
    layer.masksToBounds = false
    layer.cornerRadius = 12
  }

  private func addSubviews() {
    addSubview(categorySmallLabel)
    addSubview(imageSmallView)
    addSubview(priceLabel)
    addSubview(redactedView)
    addSubview(titleLabel)
    addSubview(urgentIcon)
  }

  private func activateConstraints() {
    categorySmallLabelConstraints()
    imageSmallViewConstraints()
    priceLabelConstraints()
    redactedViewConstraints()
    titleLabelConstraints()
    urgentIconConstraints()
  }
}

// MARK: - Constraints
extension PaperclipCell {

  private func categorySmallLabelConstraints() {
    NSLayoutConstraint.activate([
      categorySmallLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor),
      categorySmallLabel.trailingAnchor.constraint(equalTo: priceLabel.trailingAnchor),
      categorySmallLabel.bottomAnchor.constraint(equalTo: imageSmallView.bottomAnchor)
    ])
  }

  private func imageSmallViewConstraints() {
    NSLayoutConstraint.activate([
      imageSmallView.topAnchor.constraint(equalTo: topAnchor, constant: isRegular ? 24 : 16),
      imageSmallView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: isRegular ? 24 : 16),
      imageSmallView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: isRegular ? 0.44 : 0.4
                                      ),
      imageSmallView.heightAnchor.constraint(equalTo: imageSmallView.widthAnchor)
    ])
  }

  private func priceLabelConstraints() {
    NSLayoutConstraint.activate([
      priceLabel.leadingAnchor.constraint(
        equalTo: imageSmallView.trailingAnchor, constant: isRegular ? 12 : 8
      ),
      priceLabel.trailingAnchor.constraint(
        lessThanOrEqualTo: trailingAnchor, constant: isRegular ? -24 : -16
      ),
      priceLabel.bottomAnchor.constraint(
        equalTo: categorySmallLabel.topAnchor, constant: isRegular ? -8 : -4
      )
    ])
  }

  private func redactedViewConstraints() {
    NSLayoutConstraint.activate([
      redactedView.topAnchor.constraint(equalTo: imageSmallView.topAnchor),
      redactedView.leadingAnchor.constraint(equalTo: imageSmallView.leadingAnchor),
      redactedView.widthAnchor.constraint(equalTo: imageSmallView.widthAnchor),
      redactedView.heightAnchor.constraint(equalTo: imageSmallView.heightAnchor)
    ])
  }

  private func titleLabelConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(greaterThanOrEqualTo: imageSmallView.bottomAnchor, constant: isRegular ? 12 : 8),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: isRegular ? 24 : 16),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: isRegular ? -24 : -16),
      titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: isRegular ? -16 : -8)
    ])
  }

  private func urgentIconConstraints() {
    NSLayoutConstraint.activate([
      urgentIcon.trailingAnchor.constraint(
        equalTo: contentView.trailingAnchor, constant: isRegular ? -8 : -4
      ),
      urgentIcon.topAnchor.constraint(equalTo: topAnchor, constant: isRegular ? 8 : 4),
      urgentIcon.widthAnchor.constraint(equalToConstant: isRegular ? 32 : 24),
      urgentIcon.heightAnchor.constraint(equalToConstant: isRegular ? 32 : 24)
    ])
  }
}
