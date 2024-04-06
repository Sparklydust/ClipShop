//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Combine
import UIKit

/// The view that populates a list of paperclips that can be purchased by users.
class ShopListViewController: UIViewController {

  var cancellables = Set<AnyCancellable>()

  // MARK: - Views
  private(set) lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    let inset: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 16 : 32
    layout.sectionInset = UIEdgeInsets(top: .zero, left: inset, bottom: .zero, right: inset)

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(
      PaperclipCell.self, 
      forCellWithReuseIdentifier: PaperclipCell.reuseIdentifier
    )
    return collectionView
  }()

  private(set) lazy var progressView: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(style: .large)
    indicator.translatesAutoresizingMaskIntoConstraints = false
    indicator.color = .accent
    return indicator
  }()

  private(set) lazy var errorAlertView: UIAlertController = {
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

  // Initializers
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
  /// - Info: Reactive programming, making the UI responsive and dynamic.
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
      .sink { [weak self] newValues in
        self?.paperclips = newValues
        self?.collectionView.reloadData()
      }
      .store(in: &cancellables)
  }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension ShopListViewController: UICollectionViewDelegate, UICollectionViewDataSource {

  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return paperclips.count
  }

  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: PaperclipCell.reuseIdentifier, for: indexPath
    ) as? PaperclipCell
    else { return UICollectionViewCell() }

    let paperclip = paperclips[indexPath.item]
    cell.configure(with: paperclip)

    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ShopListViewController: UICollectionViewDelegateFlowLayout {

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    guard let layout = collectionViewLayout as? UICollectionViewFlowLayout
    else { return CGSize(width: 100, height: 100) }

    let hPadding = layout.sectionInset.left + layout.sectionInset.right
    let minimumInteritemSpacing = layout.minimumInteritemSpacing
    let itemsPerRow: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 2 : 3
    // `totalSpacing` is the space between cells plus the left and right padding
    let totalSpacing = (itemsPerRow - 1) * minimumInteritemSpacing + hPadding
    let availableWidth = collectionView.frame.width - totalSpacing
    let widthPerItem = availableWidth / itemsPerRow - (minimumInteritemSpacing * (itemsPerRow - 1) / itemsPerRow)

    return CGSize(width: widthPerItem, height: widthPerItem * 1.1)
  }
}

// MARK: - View Components Constraints
extension ShopListViewController {

  private func setupViewController() {
    view.backgroundColor = .systemBackground
    collectionViewConstraints()
    progressViewConstraints()
  }

  private func collectionViewConstraints() {
    view.addSubview(collectionView)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.topAnchor.constraint(equalTo: view.topAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }

  private func progressViewConstraints() {
    view.addSubview(progressView)
    NSLayoutConstraint.activate([
      progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      progressView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
}
