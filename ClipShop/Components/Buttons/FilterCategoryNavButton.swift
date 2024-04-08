//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// Navigation bar button used to filter items from a list view.
final class FilterCategoryNavButton: UIBarButtonItem {

  @Published var selectedItem: Int? = .none {
    didSet { menu = setupCategoriesMenu() }
  }
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

  private func setupCategoriesMenu() -> UIMenu {
    let menuItems = categories.map { category in
      return UIAction(
        title: category.name,
        state: category.id == selectedItem ? .on : .off,
        handler: { [weak self] _ in self?.handleCategorySelection(category) }
      )
    }
    let dismissSelection = UIAction(
      title: "Réinitialiser",
      attributes: .destructive,
      handler: { [weak self] _ in self?.selectedItem = .none }
    )

    return UIMenu(title: "Catégories", children: menuItems + [dismissSelection])
  }

  private func handleCategorySelection(_ category: CategoryModel) {
    selectedItem = category.id
  }
}
