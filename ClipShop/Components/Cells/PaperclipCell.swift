//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// Cell component to populate ``PaperclipModel`` within the ``ShopListViewController`` within
/// a collection view cell.
class PaperclipCell: UICollectionViewCell {

  private let title: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .accent
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
    self.title.text = model.title
  }
}

// MARK: - View Components Constraints
extension PaperclipCell {

  private func setupCell() {
    setupLayer()
    setupTitle()
  }

  private func setupLayer() {
    layer.cornerRadius = 4
    layer.masksToBounds = true
  }

  private func setupTitle() {
    addSubview(title)
    NSLayoutConstraint.activate([
      title.centerXAnchor.constraint(equalTo: centerXAnchor),
      title.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }
}
