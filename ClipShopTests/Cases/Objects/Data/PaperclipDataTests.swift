//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import XCTest
@testable import ClipShop

final class PaperclipDataTests: XCTestCase {

  var sut: PaperclipData!

  override func setUp() async throws {
    try await super.setUp()
    sut = .fake()
  }

  override func tearDown() async throws {
    sut = .none
    try await super.tearDown()
  }

  func testInitialization_id_returnsAssociatedFakeValue() {
    let expected = PaperclipData.fake().id

    let result = sut.id

    XCTAssertEqual(result, expected, "`id` must be equal to `\(expected)` when initialized with its fake value.")
  }

  func testInitialization_categoryID_returnsAssociatedFakeValue() {
    let expected = PaperclipData.fake().categoryID

    let result = sut.categoryID

    XCTAssertEqual(result, expected, "`categoryID` must be equal to `\(expected)` when initialized with its fake value.")
  }

  func testInitialization_title_returnsAssociatedFakeValue() {
    let expected = PaperclipData.fake().title

    let result = sut.title

    XCTAssertEqual(result, expected, "`title` must be equal to `\(expected)` when initialized with its fake value.")
  }

  func testInitialization_description_returnsAssociatedFakeValue() {
    let expected = PaperclipData.fake().description

    let result = sut.description

    XCTAssertEqual(result, expected, "`description` must be equal to `\(expected)` when initialized with its fake value.")
  }

  func testInitialization_price_returnsAssociatedFakeValue() {
    let expected = PaperclipData.fake().price

    let result = sut.price

    XCTAssertEqual(result, expected, "`price` must be equal to `\(expected)` when initialized with its fake value.")
  }

  func testInitialization_imageURLsSmall_returnsAssociatedFakeValue() throws {
    let expected = try XCTUnwrap(PaperclipData.fake().imageURLs.small)

    let result = sut.imageURLs.small

    XCTAssertEqual(result, expected, "`imageURLs.small` must be equal to `\(expected)` when initialized with its fake value.")
  }

  func testInitialization_imageURLsSmallHasNoValue_returnsNil() {
    sut = PaperclipData.fake(imageURLs: .fake(small: .none))

    let result = sut.imageURLs.small

    XCTAssertNil(result, "`imageURLs.small` must be nil has no value was passed in.")
  }

  func testInitialization_imageURLsThumb_returnsAssociatedFakeValue() throws {
    let expected = try XCTUnwrap(PaperclipData.fake().imageURLs.thumb)

    let result = sut.imageURLs.thumb

    XCTAssertEqual(result, expected, "`imageURLs.thumb` must be equal to `\(expected)` when initialized with its fake value.")
  }

  func testInitialization_imageURLsThumbHasNoValue_returnsNil() {
    sut = PaperclipData.fake(imageURLs: .fake(thumb: .none))

    let result = sut.imageURLs.thumb

    XCTAssertNil(result, "`imageURLs.thumb` must be nil has no value was passed in.")
  }

  func testInitialization_creationDate_returnsAssociatedFakeValue() {
    let expected = PaperclipData.fake().creationDate

    let result = sut.creationDate

    XCTAssertEqual(result, expected, "`creationDate` must be equal to `\(expected)` when initialized with its fake value.")
  }

  func testInitialization_isUrgent_returnsAssociatedFakeValue() {
    let expected = PaperclipData.fake().isUrgent

    let result = sut.isUrgent

    XCTAssertEqual(result, expected, "`isUrgent` must be equal to `\(expected)` when initialized with its fake value.")
  }

  func testInitialization_siret_returnsAssociatedFakeValue() throws {
    let expected = try XCTUnwrap(PaperclipData.fake().siret)

    let result = sut.siret

    XCTAssertEqual(result, expected, "`siret` must be equal to `\(expected))` when initialized with its fake value.")
  }

  func testInitialization_siretHasNoValue_returnsNil() {
    sut = PaperclipData.fake(siret: .none)

    let result = sut.siret

    XCTAssertNil(result, "`siret` must be nil has no value was passed in.")
  }
}
