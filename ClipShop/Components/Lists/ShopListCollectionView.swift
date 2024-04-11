//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// A customized collection view displaying paperclip items in the ``ShopListViewController``.
final class ShopListCollectionView: UICollectionView {

  /// Initializes a new instance of the collection view with a predefined layout.
  init() {
    let isRegular = UIDevice.current.userInterfaceIdiom == .pad
    let inset: CGFloat = isRegular ? 36 : 16

    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.sectionInset = UIEdgeInsets(top: .zero, left: inset, bottom: .zero, right: inset)
    layout.minimumLineSpacing = isRegular ? 32 : 20

    super.init(frame: .zero, collectionViewLayout: layout)
    setupCollectionView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  /// Sets up the collection view's delegate, data source, and cell registration.
  private func setupCollectionView() {
    translatesAutoresizingMaskIntoConstraints = false
    delegate = self as? UICollectionViewDelegate
    dataSource = self as? UICollectionViewDataSource
    register(PaperclipCell.self, forCellWithReuseIdentifier: PaperclipCell.reuseIdentifier)
  }
}
