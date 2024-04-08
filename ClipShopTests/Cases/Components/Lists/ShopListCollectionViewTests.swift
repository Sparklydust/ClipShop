//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//
import XCTest
@testable import ClipShop

final class ShopListCollectionViewTests: XCTestCase {

  var sut: ShopListCollectionView!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = ShopListCollectionView()
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }

  func testInitialization_scrollDirection_isVertical() throws {
    let layout = try XCTUnwrap(sut.collectionViewLayout as? UICollectionViewFlowLayout)
    let expected: UICollectionView.ScrollDirection = .vertical

    let result = layout.scrollDirection

    XCTAssertEqual(result, .vertical, "Scroll direction must be equal to `\(expected)` on initialization.")
  }
}
