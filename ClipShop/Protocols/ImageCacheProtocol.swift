//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation

protocol ImageCacheProtocol {

  /// Writes data to disk with the specified file name.
  /// - Parameters:
  ///   - data: The data to save in disk.
  ///   - name: The name of the data to save.
  func write(_ data: Data, name: String) throws
  
  /// Reads and returns data from a file with the specified name.
  /// - Parameter name: The name of the saved data.
  /// - Returns: The data found in disk.
  func read(name: String) throws -> Data
}
