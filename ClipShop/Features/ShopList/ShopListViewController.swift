//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import UIKit

/// The view that populates a list of paperclips that can be purchased by users.
class ShopListViewController: UIViewController {

  private var viewModel: ShopListViewModel

  init(viewModel: ShopListViewModel = ShopListViewModel()) {
    self.viewModel = viewModel
    super.init(nibName: .none, bundle: .none)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
  }
}
