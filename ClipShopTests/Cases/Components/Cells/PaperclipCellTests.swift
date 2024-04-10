//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class PaperclipCellTests: XCTestCase {

  var sut: PaperclipCell!

  override func setUp() async throws {
    try await super.setUp()
    sut = await PaperclipCell(frame: .zero)
  }

  override func tearDown() async throws {
    sut = nil
    try await super.tearDown()
  }

  func testInitializer_reuseIdentifier_isEqualToPaperclipCellString() {
    let expected = "PaperclipCell"

    let result = PaperclipCell.reuseIdentifier

    XCTAssertEqual(result, expected, "Cell `reuseIdentifier` must be equal to `\(expected)` when initialized.")
  }

  func testConfigurations_configureWithPaperclipModelImage_imageSmallViewIsNotEmpty() throws {
    let expected = try XCTUnwrap(UIImage(systemName: "gear"))
    var fake: PaperclipModel = .fake()
    fake.image = expected
    sut.configure(with: fake)

    let result = sut.imageSmallView.image

    XCTAssertEqual(result, expected, "cell image must be equal to `\(expected)` when configured with model image.")
  }

  func testConfigurations_titleLabelTextConfiguredWithPaperclipModel_titleIsEqualToModelTitle() {
    sut.configure(with: .fake())
    let expected = PaperclipModel.fake().title

    let result = sut.titleLabel.text

    XCTAssertEqual(result, expected, "`titleLabel.text` must be equal to `\(expected)` when configured with model.")
  }

  func testConfigurations_priceSmallLabelTextConfiguredWithPaperclipModel_priceIsEqualToModelPrice() {
    sut.configure(with: .fake())
    let expected = "\(PaperclipModel.fake().price)€"

    let result = sut.priceSmallLabel.text

    XCTAssertEqual(result, expected, "`priceSmallLabel.text` must be equal to `\(expected)` when configured with model.")
  }

  func testConfigurations_categorySmallLabelTextConfiguredWithPaperclipModel_categoryIsEqualToModelCategory() {
    sut.configure(with: .fake())
    let expected = PaperclipModel.fake().category.name

    let result = sut.categorySmallLabel.text

    XCTAssertEqual(result, expected, "`categorySmallLabel.text` must be equal to `\(expected)` when configured with model.")
  }

  func testConfigurations_urgentIconConfiguredWithPaperclipModelThatIsUrgent_urgentIconIsNotHiddent() {
    sut.configure(with: .fake(with: (.fake(isUrgent: true), [.fake()])))

    let result = sut.urgentIcon.isHidden

    XCTAssertFalse(result, "`urgentIcon` must be not be hidden when configured with model that is urgent.")
  }

  func testConfigurations_urgentIconConfiguredWithPaperclipModelThatIsNotUrgent_urgentIconIsHiddent() {
    sut.configure(with: .fake(with: (.fake(isUrgent: false), [.fake()])))

    let result = sut.urgentIcon.isHidden

    XCTAssertTrue(result, "`urgentIcon` must be be hidden when configured with model that is not urgent.")
  }
}
