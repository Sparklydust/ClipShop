//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class PaperclipModelTests: XCTestCase {

  var sut: PaperclipModel!

  override func setUp() async throws {
    try await super.setUp()
    sut = PaperclipModel(with: (.fake(), [.fake()]))
  }

  override func tearDown() async throws {
    sut = nil
    try await super.tearDown()
  }

  func testInitialization_id_isEqualToValueFromPassedDataObjectInInit() {
    let expected = PaperclipData.fake().id

    let result = sut.id

    XCTAssertEqual(result, expected, "`id` value must be equal to `\(expected)` data object value from init parameter.")
  }

  func testInitialization_imageURLSmall_isEqualToValueFromPassedDataObjectInInit() throws {
    let expected = try XCTUnwrap(PaperclipData.fake().imageURLs.small)

    let result = sut.imageURL.small

    XCTAssertEqual(result, expected, "`imageURL.small` value must be equal to `\(expected)` data object value from init parameter.")
  }

  func testInitialization_imageURLThumb_isEqualToValueFromPassedDataObjectInInit() throws {
    let expected = try XCTUnwrap(PaperclipData.fake().imageURLs.thumb)

    let result = sut.imageURL.thumb

    XCTAssertEqual(result, expected, "`imageURL.thumb` value must be equal to `\(expected)` data object value from init parameter.")
  }

  func testInitialization_image_isEqualToNil() {
    let expected: UIImage? = .none

    let result = sut.image

    XCTAssertEqual(result, expected, "`image` value must be equal to `\(String(describing: expected))` when initialized.")
  }

  func testInitialization_title_isEqualToValueFromPassedDataObjectInInit() {
    let expected = PaperclipData.fake().title

    let result = sut.title

    XCTAssertEqual(result, expected, "`title` value must be equal to `\(expected)` data object value from init parameter.")
  }

  func testInitialization_price_isEqualToValueFromPassedDataObjectInInit() {
    let expected = PaperclipData.fake().price

    let result = sut.price

    XCTAssertEqual(result, expected, "`price` value must be equal to `\(expected)` data object value from init parameter.")
  }

  func testInitialization_category_isEqualToCategoryModelWithPassedDataObjectInInit() {
    let expected = CategoryModel(with: .fake())

    let result = sut.category

    XCTAssertEqual(result, expected, "`category` value must be equal to `\(expected)` data object value from init parameter.")
  }

  func testInitialization_isUrgent_isEqualToValueFromPassedDataObjectInInit() {
    let expected = PaperclipData.fake().isUrgent

    let result = sut.isUrgent

    XCTAssertEqual(result, expected, "`isUrgent` value must be equal to `\(expected)` data object value from init parameter.")
  }

  func testInitialization_creationDate_isEqualToDateValueFromPassedDataObjectInInit() throws {
    let expected = try XCTUnwrap(ISO8601DateFormatter().date(from: PaperclipData.fake().creationDate))

    let result = sut.creationDate

    XCTAssertEqual(result, expected, "`isUrgent` value must be equal to `\(expected)` data object value from init parameter.")
  }

  func testInitialization_description_isEqualToValueFromPassedDataObjectInInit() {
    let expected = PaperclipData.fake().description

    let result = sut.description

    XCTAssertEqual(result, expected, "`description` value must be equal to `\(expected)` data object value from init parameter.")
  }

  func testInitialization_siretWhenPaperclipDataOneIsOptional_isEqualToEmptyString() {
    sut = PaperclipModel(with: (.fake(siret: .none), [.fake()]))
    let expected = String()

    let result = sut.siret

    XCTAssertEqual(result, expected, "`siret` value must be equal to `\(expected)` when data value is nil.")
  }

  func testInitialization_siret_isEqualToValueFromPassedDataObjectInInit() throws {
    let expected = try XCTUnwrap(PaperclipData.fake().siret)

    let result = sut.siret

    XCTAssertEqual(result, expected, "`siret` value must be equal to `\(expected)` data object value from init parameter.")
  }
}
