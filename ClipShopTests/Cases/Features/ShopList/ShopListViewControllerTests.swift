//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Combine
import XCTest
@testable import ClipShop

final class ShopListViewControllerTests: BaseXCTestCase {

  var sut: ShopListViewController!

  var cancellables: Set<AnyCancellable>!
  var viewModelFake: ShopListViewModel!

  override func setUp() async throws {
    try await super.setUp()
    cancellables = Set<AnyCancellable>()
    viewModelFake = ShopListViewModel(server: serverDummy)

    sut = await ShopListViewController(viewModel: viewModelFake)
    await sut.loadViewIfNeeded()
  }

  override func tearDown() async throws {
    cancellables = nil
    viewModelFake = nil
    sut = nil
    try await super.tearDown()
  }

  func testsInitialization_paperclips_isEqualToEmptyArrayPaperclipModel() {
    let expected = [PaperclipModel]()

    let result = sut.paperclips

    XCTAssertEqual(result, expected, "`paperclips` array must be equal to `\(expected)` when initialized.")
  }

  func testInitialization_viewBackgroundColor_isEqualToSystemBackground() {
    let expected: UIColor = .systemBackground

    let result = sut.view.backgroundColor

    XCTAssertEqual(result, expected, "View `backgroundColor` must be equal to `\(expected)`.")
  }

  func testInitialization_progressView_isEqualToAccent() {
    let expected: UIColor = .accent

    let result = sut.progressView.color

    XCTAssertEqual(result, expected, "`progressView` color must be equal to `\(expected)`.")
  }

  func testInitialization_errorAlertView_isEqualToServerError() {
    let expected = "Server Error"

    let result = sut.errorAlertView.title

    XCTAssertEqual(result, expected, "`errorAlertView` title must be equal to `\(expected)`.")
  }

  func testPipelines_viewModelIsLoadingData_progressViewIsAnimating() {
    let expectation = expectation(description: "Going through the viewModel.$isLoading pipeline.")
    viewModelFake.isLoading = true

    viewModelFake.$isLoading.sink { _ in
      let result = self.sut.progressView.isAnimating

      expectation.fulfill()
      XCTAssertTrue(result, "`progressView` must be animating when view model is loading data.")
    }
    .store(in: &cancellables)
    wait(for: [expectation], timeout: 1)
  }

  func testPipelines_viewModelIsNotLoadingData_progressViewIsNotAnimating() {
    let expectation = expectation(description: "Going through the viewModel.$isLoading pipeline.")
    viewModelFake.isLoading = false

    viewModelFake.$isLoading.sink { _ in
      let result = self.sut.progressView.isAnimating

      expectation.fulfill()
      XCTAssertFalse(result, "`progressView` must be not be animating when view model is not loading data.")
    }
    .store(in: &cancellables)
    wait(for: [expectation], timeout: 1)
  }

  func testPipelines_viewModelTriggerShowError_errorAlertViewIsPresented() {
    let expectation = expectation(description: "Going through the viewModel.$showError pipeline.")
    viewModelFake.showError = true

    viewModelFake.$showError.sink { _ in
      let result = self.sut.errorAlertView.view.isHidden

      expectation.fulfill()
      XCTAssertFalse(result, "`errorAlertView` must be not be hidden when view model trigger error from request.")
    }
    .store(in: &cancellables)
    wait(for: [expectation], timeout: 1)
  }

  func testPipelines_viewModelDoesNotTriggerShowError_errorAlertViewIsNotPresented() {
    let expectation = expectation(description: "Going through the viewModel.$showError pipeline.")
    viewModelFake.showError = false

    viewModelFake.$showError.sink { _ in
      let result = self.sut.errorAlertView.view.isHidden

      expectation.fulfill()
      XCTAssertTrue(result, "`errorAlertView` must be be hidden when view model trigger error from request.")
    }
    .store(in: &cancellables)
    wait(for: [expectation], timeout: 1)
  }

  func testPipelines_viewModelSendPaperclipsItems_paperclipsIsNotEmpty() {
    let expectation = expectation(description: "Going through the viewModel.$paperclips item pipeline.")
    let paperclipsFake: [PaperclipModel] = [.fake(), .fake()]
    viewModelFake.paperclips = paperclipsFake
    let expected = paperclipsFake.count

    viewModelFake.$paperclips.sink { _ in
      let result = self.sut.paperclips.count

      expectation.fulfill()
      XCTAssertEqual(result, expected, "sut must have `\(expected)` paperclips items to be shown on view.")
    }
    .store(in: &cancellables)
    wait(for: [expectation], timeout: 1)
  }

  func testPipelines_viewModelSend3PaperclipsItemsWith2Categories_paperclipsHas2LeftItemsFollowingFilterredByCategoryButtonSelectedItem() {
    let expectation = expectation(description: "Going through the viewModel.$paperclips item pipeline.")
    let paperclipsFake: [PaperclipModel] = [
      .fake(with: (.fake(categoryID: 2), [.fake(id: 2), .fake(id: 3)])),
      .fake(with: (.fake(categoryID: 3), [.fake(id: 2), .fake(id: 3)])),
      .fake(with: (.fake(categoryID: 2), [.fake(id: 2), .fake(id: 3)]))
    ]
    viewModelFake.paperclips = paperclipsFake
    sut.filterCategoryButton.selectedItem = 2
    let expected = 2

    viewModelFake.$paperclips.sink { _ in
      let result = self.sut.paperclips.count

      expectation.fulfill()
      XCTAssertEqual(result, expected, "sut must have `\(expected)` paperclips items to be shown on view.")
    }
    .store(in: &cancellables)
    wait(for: [expectation], timeout: 1)
  }

  func testPipelines_viewModelSendCategoriesCategories_filterCategoryButtonCategoriesValueIsNotEmpty() {
    let expectation = expectation(description: "Going through the viewModel.$categories item pipeline.")
    let categoriesFake: [CategoryModel] = [.fake(), .fake()]
    viewModelFake.categories = categoriesFake
    let expected = categoriesFake.count

    viewModelFake.$categories.sink { _ in
      let result = self.sut.filterCategoryButton.categories.count

      expectation.fulfill()
      XCTAssertEqual(result, expected, "`filterCategoryButton` must have `\(expected)` categories items to be shown on its menu.")
    }
    .store(in: &cancellables)
    wait(for: [expectation], timeout: 1)
  }
}
