//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Combine
import UIKit

/// The view that populates a list of paperclips that can be purchased by users.
final class ShopListViewController: UIViewController {

  var cancellables = Set<AnyCancellable>()
  weak var delegate: ShopListViewControllerDelegate?

  // MARK: - Components
  private(set) var collectionView = ShopListCollectionView()
  private(set) var progressView = ProgressLargeView(frame: .zero)
  private(set) lazy var errorAlertView: UIAlertController = .serverErrorAlert
  private(set) var filterCategoryButton: FilterCategoryNavButton!

  // MARK: - Models
  private(set) var paperclips = [PaperclipModel]()
  private var viewModel: ShopListViewModel

  init(viewModel: ShopListViewModel) {
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

// MARK: - Pipelines
extension ShopListViewController {

  /// Listening to Combine pipelines from the `viewModel` observing its changes to update `view`.
  /// - Info: Reactive programming, making the UI responsive and dynamic.
  @MainActor private func observeViewModelPipelines() {
    progressViewPipeline()
    errorPipeline()
    paperclipsPipeline()
    categoriesPipeline()
  }

  private func progressViewPipeline() {
    viewModel.$isLoading
      .sink { [weak self] isLoading in
        self?.view.isUserInteractionEnabled = !isLoading
        isLoading ? self?.progressView.startAnimating() : self?.progressView.stopAnimating()
      }
      .store(in: &cancellables)
  }

  private func errorPipeline() {
    viewModel.$showError
      .sink { [weak self] showError in
        self?.errorAlertView.view.isHidden = !showError
        guard showError, let self else { return }
        self.present(self.errorAlertView, animated: true)
      }
      .store(in: &cancellables)
  }

  private func paperclipsPipeline() {
    viewModel.$paperclips
      .combineLatest(filterCategoryButton.$selectedItem)
      .map { newValues, selectedCategory -> [PaperclipModel] in
        guard let selectedCategory else { return newValues }
        return newValues.filter { $0.category.id == selectedCategory }
      }
      .sink { [weak self] newValues in
        self?.paperclips = newValues
        self?.collectionView.reloadData()
      }
      .store(in: &cancellables)
  }

  private func categoriesPipeline() {
    viewModel.$categories
      .sink { [weak self] newValues in
        self?.filterCategoryButton.categories = newValues
        self?.filterCategoryButton.isEnabled = !newValues.isEmpty
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

  func collectionView(
    _ collectionView: UICollectionView,
    willDisplay cell: UICollectionViewCell,
    forItemAt indexPath: IndexPath
  ) {
    guard let cell = cell as? PaperclipCell, cell.imageSmallView.image == .none else { return }
    let paperclip = paperclips[indexPath.item]
    populateImage(paperclip: paperclip, on: cell)
  }

  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    let paperclip = paperclips[indexPath.item]
    delegate?.didSelectItem(paperclip)
  }

  /// Request the small image of the paperclip to be populated on the corresponding cell.
  /// - Parameters:
  ///   - paperclip: The paperclip item to get the image from.
  ///   - cell: The cell on which the image must be populated on.
  private func populateImage(
    paperclip: PaperclipModel,
    on cell: PaperclipCell
  ) {
    guard paperclip.imageURL.small != .none,
          let urlString = paperclip.imageURL.small
    else { return }

    Task { @MainActor [weak self] in
      let image = await self?.viewModel.loadImage(urlString: urlString)
      cell.imageConfiguration(with: image)
    }
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
    let isRegular = UIDevice.current.userInterfaceIdiom == .pad
    let hPadding = layout.sectionInset.left + layout.sectionInset.right
    let minimumInteritemSpacing = layout.minimumInteritemSpacing + (isRegular ? 28 : 8)
    let itemsPerRow: CGFloat = isRegular ? 3 : 2
    // `totalSpacing` is the space between cells plus the left and right padding
    let totalSpacing = (itemsPerRow - 1) * minimumInteritemSpacing + hPadding
    let availableWidth = collectionView.frame.width - totalSpacing
    let widthPerItem = availableWidth / itemsPerRow

    return CGSize(width: widthPerItem, height: widthPerItem * (isRegular ? 1.05 : 1.1))
  }
}

// MARK: - View Components Constraints
extension ShopListViewController {

  private func setupViewController() {
    view.backgroundColor = .systemBackground
    setupDelegates()
    setupNavigationBar()
    collectionViewConstraints()
    progressViewConstraints()
  }

  private func setupDelegates() {
    collectionView.delegate = self
    collectionView.dataSource = self
  }

  private func setupNavigationBar() {
    filterCategoryButton = FilterCategoryNavButton()
    filterCategoryButton.isEnabled = false
    navigationItem.rightBarButtonItem = filterCategoryButton
  }

  private func collectionViewConstraints() {
    view.addSubview(collectionView)
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
