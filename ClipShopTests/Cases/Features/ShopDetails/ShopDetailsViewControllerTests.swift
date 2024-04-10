//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Combine
import XCTest
@testable import ClipShop

final class ShopDetailsViewControllerTests: BaseXCTestCase {

  var sut: ShopDetailsViewController!

  var cancellables: Set<AnyCancellable>!
  var viewModelFake: ShopDetailsViewModel!

  override func setUp() async throws {
    try await super.setUp()
    cancellables = Set<AnyCancellable>()
    viewModelFake = ShopDetailsViewModel(server: serverDummy)

    sut = await ShopDetailsViewController(viewModel: viewModelFake, paperclip: .fake())
    await sut.loadViewIfNeeded()
  }

  override func tearDown() async throws {
    cancellables = nil
    viewModelFake = nil
    sut = nil
    try await super.tearDown()
  }

  func testInitialization_viewBackgroundColor_isEqualToSystemBackground() {
    let expected: UIColor = .systemBackground

    let result = sut.view.backgroundColor

    XCTAssertEqual(result, expected, "View `backgroundColor` must be equal to `\(expected)`.")
  }

  func testInitialization_title_isEqualToPassedPaperclipCategoryNamePassedInInit() {
    let expected = PaperclipModel.fake().category.name

    let result = sut.title

    XCTAssertEqual(result, expected, "View `title` must be equal to `\(expected)`.")
  }

  func testConfigurations_dateLabel_isEqualToPaperclipModelDatePassedInParameter() {
    let expected = PaperclipModel.fake().creationDate.toString()

    let result = sut.dateLabel.text

    XCTAssertEqual(result, expected, "`dateLabel.text` must be equal to `\(expected)` when configured.")
  }

  func testConfigurations_descriptionLabel_isEqualToPaperclipModelValuePassedInParameter() {
    let expected = PaperclipModel.fake().description

    let result = sut.descriptionLabel.text

    XCTAssertEqual(result, expected, "`descriptionLabel.text` must be equal to `\(expected)` when configured.")
  }

  func testConfigurations_priceLabel_isEqualToPaperclipModelValuePassedInParameter() {
    let expected = "\(PaperclipModel.fake().price)€"

    let result = sut.priceLabel.text

    XCTAssertEqual(result, expected, "`priceLabel.text` must be equal to `\(expected)` when configured.")
  }

  func testConfigurations_siretLabel_isEqualToPaperclipModelValuePassedInParameter() {
    let expected = PaperclipModel.fake().siret

    let result = sut.siretLabel.text

    XCTAssertEqual(result, expected, "`siretLabel.text` must be equal to `\(expected)` when configured.")
  }

  func testConfigurations_titleLabel_isEqualToPaperclipModelValuePassedInParameter() {
    let expected = PaperclipModel.fake().title

    let result = sut.titleLabel.text

    XCTAssertEqual(result, expected, "`titleLabel.text` must be equal to `\(expected)` when configured.")
  }

  func testPipelines_viewModelItemImageIsNotNil_imageViewImageIsNotNil() {
    let expectation = expectation(description: "Going through the viewModel.$itemImage pipeline.")
    viewModelFake.itemImage = UIImage(systemName: "gear")

    viewModelFake.$itemImage.sink { _ in
      let result = self.sut.imageView.image

      expectation.fulfill()
      XCTAssertNotNil(result, "`imageView.image` must not be nil when view model load an `itemImage`.")
    }
    .store(in: &cancellables)
    waitForExpectations(timeout: 1)
  }

  func testPipelines_viewModelItemImageIsNil_imageViewImageIsNil() {
    let expectation = expectation(description: "Going through the viewModel.$itemImage pipeline.")
    viewModelFake.itemImage = .none

    viewModelFake.$itemImage.sink { _ in
      let result = self.sut.imageView.image

      expectation.fulfill()
      XCTAssertNil(result, "`imageView.image` must be nil when view model did not load an `itemImage`.")
    }
    .store(in: &cancellables)
    wait(for: [expectation], timeout: 1)
  }

  func testPipelines_viewModelItemImageIsNotNil_redactedViewIsHidden() {
    let expectation = expectation(description: "Going through the viewModel.$itemImage pipeline.")
    viewModelFake.itemImage = UIImage(systemName: "gear")

    viewModelFake.$itemImage.sink { _ in
      let result = self.sut.redactedView.isHidden

      expectation.fulfill()
      XCTAssertTrue(result, "`redactedView` must be hidden when view model load an `itemImage`.")
    }
    .store(in: &cancellables)
    waitForExpectations(timeout: 1)
  }

  func testPipelines_viewModelItemImageIsNil_redactedViewIsNotHidden() {
    let expectation = expectation(description: "Going through the viewModel.$itemImage pipeline.")
    viewModelFake.itemImage = .none

    viewModelFake.$itemImage.sink { _ in
      let result = self.sut.redactedView.isHidden

      expectation.fulfill()
      XCTAssertFalse(result, "`redactedView` must not be hidden when view model did not load an `itemImage`.")
    }
    .store(in: &cancellables)
    waitForExpectations(timeout: 1)
  }
}
