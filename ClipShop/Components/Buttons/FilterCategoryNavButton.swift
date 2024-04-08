//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// Navigation bar button used to filter items from a list view.
final class FilterCategoryNavButton: UIBarButtonItem {

  var categories: [CategoryModel] = [] {
    didSet { menu = setupCategoriesMenu() }
  }

  override init() {
    super.init()
    setupButton()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Setup
extension FilterCategoryNavButton {

  func setupButton() {
    target = self
    image = UIImage(systemName: "line.3.horizontal.decrease.circle")
    tintColor = .accent
  }
}

// MARK: - Menu
extension FilterCategoryNavButton {

  func setupCategoriesMenu() -> UIMenu {
    let menuItems = categories.map { UIAction(title: $0.name, handler: { _ in }) }
    let dismissSelection = UIAction(title: "Réinitialiser", attributes: .destructive, handler: { _ in })
    let children = menuItems + [dismissSelection]

    return UIMenu(children: children)
  }
}
