//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// Cell component to populate ``PaperclipModel`` within the ``ShopListViewController`` within
/// a collection view cell.
class PaperclipCell: UICollectionViewCell {

  static let reuseIdentifier = "PaperclipCell"

  private(set) var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    imageView.layer.cornerRadius = 8
    imageView.clipsToBounds = true
    return imageView
  }()

  /// Placeholder view for when the image is nil.
  private let redactedView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor.systemGray4
    view.layer.cornerRadius = 8
    return view
  }()

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .left
    label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    label.numberOfLines = 0
    label.allowsDefaultTighteningForTruncation = true
    return label
  }()

  private let priceLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .left
    label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    return label
  }()

  private let categoryLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .left
    label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    label.textColor = .secondaryLabel
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupCell()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Cell Configuration
extension PaperclipCell {

  /// Define the cell values from the model passed in the parameter.
  /// - Parameter model: The ``PaperclipModel`` instance containing the data from the server
  /// adapted to be displayed on the cell.
  func configure(with model: PaperclipModel) {
    imageConfiguration(with: model.image)
    titleLabel.text = model.title
    priceLabel.text = "\(model.price)€"
    categoryLabel.text = model.category
  }
  
  /// Define the image to be populated on the cell.
  /// - Parameter image: The image to be shown if any else, `redactedView` is presented.
  func imageConfiguration(with image: UIImage?) {
    imageView.image = image
    imageView.isHidden = image == .none
    redactedView.isHidden = image != .none
  }
}

// MARK: - Cell Setup
extension PaperclipCell {

  private func setupCell() {
    backgroundColor = .accent
    layer.cornerRadius = 12
    layer.masksToBounds = true

    addSubview(imageView)
    addSubview(redactedView)
    addSubview(titleLabel)
    addSubview(priceLabel)
    addSubview(categoryLabel)

    imageViewConstraints()
    redactedViewConstraints()
    titleLabelConstraints()
    priceLabelConstraints()
    categoryLabelConstraints()
  }

  private func imageViewConstraints() {
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      imageView.widthAnchor.constraint(
        equalTo: widthAnchor,
        multiplier: UIDevice.current.userInterfaceIdiom == .phone ? 0.4 : 0.5
      ),
      imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
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

  private func titleLabelConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(greaterThanOrEqualTo: imageView.bottomAnchor, constant: 8),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
    ])
  }

  private func priceLabelConstraints() {
    NSLayoutConstraint.activate([
      priceLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
      priceLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),
      priceLabel.bottomAnchor.constraint(equalTo: categoryLabel.topAnchor, constant: -4)
    ])
  }

  private func categoryLabelConstraints() {
    NSLayoutConstraint.activate([
      categoryLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor),
      categoryLabel.trailingAnchor.constraint(equalTo: priceLabel.trailingAnchor),
      categoryLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
    ])
  }
}
