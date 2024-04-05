//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Combine
import UIKit

/// The view that populates a list of paperclips that can be purchased by users.
class ShopListViewController: UIViewController {

  var cancellables = Set<AnyCancellable>()

  // MARK: - Views
  private(set) var progressView: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(style: .large)
    indicator.translatesAutoresizingMaskIntoConstraints = false
    indicator.color = .accent
    return indicator
  }()

  private(set) var errorAlertView: UIAlertController = {
    let alert = UIAlertController(
      title: "Server Error",
      message: "Connect to the world wide web and restart ClipShop.",
      preferredStyle: .alert
    )
    alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
    alert.view.tintColor = .accent
    return alert
  }()

  // MARK: - Models
  private var paperclips = [PaperclipModel]()
  private var viewModel: ShopListViewModel

  // MARK: - Initializers
  init(viewModel: ShopListViewModel = ShopListViewModel()) {
    self.viewModel = viewModel
    super.init(nibName: .none, bundle: .none)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewController()
    observeViewModelPipelines()
    Task { await viewModel.getPaperclipsList() }
  }
}

// MARK: - View Model Pipelines
extension ShopListViewController {

  /// Listening to Combine pipelines from the `viewModel` observing its changes to update `view`.
  @MainActor private func observeViewModelPipelines() {
    viewModel.$isLoading
      .sink { [weak self] isLoading in
        self?.view.isUserInteractionEnabled = !isLoading
        isLoading ? self?.progressView.startAnimating() : self?.progressView.stopAnimating()
      }
      .store(in: &cancellables)

    viewModel.$showError
      .sink { [weak self] showError in
        self?.errorAlertView.view.isHidden = !showError
        guard showError, let self else { return }
        self.present(self.errorAlertView, animated: true)
      }
      .store(in: &cancellables)

    viewModel.$paperclips
      .sink { [weak self] newValues in self?.paperclips = newValues }
      .store(in: &cancellables)
  }
}

// MARK: - View Components Constraints
extension ShopListViewController {

  private func setupViewController() {
    view.backgroundColor = .systemBackground
    progressViewConstraints()
  }

  private func progressViewConstraints() {
    view.addSubview(progressView)
    NSLayoutConstraint.activate([
      progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      progressView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
}
