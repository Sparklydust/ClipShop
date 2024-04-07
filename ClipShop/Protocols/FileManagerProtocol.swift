//
// Copyright © 2024 and confidential to ClipShop. All rights reserved.
//

import Foundation

/// Add URLSessionProtocol on top of ``URLSession`` to reduce the dependency for testing.
extension FileManager: FileManagerProtocol {
  // Intentionally empty
}

protocol FileManagerProtocol {

  /// Returns an array of URLs for the specified common directory in the requested domains.
  /// This method is intended to locate known and common directories in the system. For example,
  /// setting the directory to FileManager.SearchPathDirectory.applicationDirectory, will return the
  /// Applications directories in the requested domain. There are a number of common directories
  /// available in the FileManager.SearchPathDirectory, including:
  /// FileManager.SearchPathDirectory.desktopDirectory,
  /// FileManager.SearchPathDirectory.applicationSupportDirectory, and many more.
  /// - Parameters:
  ///   - directory: The search path directory. The supported values are described in
  ///   FileManager.SearchPathDirectory.
  ///   - domainMask: The file system domain to search. The value for this parameter is one or more of
  ///   the constants described in FileManager.SearchPathDomainMask.
  /// - Returns: An array of NSURL objects identifying the requested directories. The directories are
  /// ordered according to the order of the domain mask constants, with items in the user domain first
  /// and items in the system domain last.
  func urls(
    for directory: FileManager.SearchPathDirectory,
    in domainMask: FileManager.SearchPathDomainMask
  ) -> [URL]

  /// Creates a directory with the given attributes at the specified URL.
  /// - Parameters:
  ///   - url: A file URL that specifies the directory to create. If you want to specify a relative
  ///   path, you must set the current working directory before creating the corresponding NSURL
  ///   object. This parameter must not be nil.
  ///   - createIntermediates: If true, this method creates any nonexistent parent directories as part
  ///   of creating the directory in url. If false, this method fails if any of the intermediate
  ///   parent directories does not exist.
  ///   - attributes: The file attributes for the new directory. You can set the owner and group
  ///   numbers, file permissions, and modification date. If you specify nil for this parameter, the
  ///   directory is created according to the umask(2) macOS Developer Tools Manual Page of the
  ///   process. The Supporting Types section lists the global constants used as keys in the
  ///   attributes dictionary. Some of the keys, such as hfsCreatorCode and hfsTypeCode, do not apply
  ///   to directories.
  func createDirectory(
    at url: URL, withIntermediateDirectories createIntermediates: Bool,
    attributes: [FileAttributeKey : Any]?
  ) throws

  /// Removes the file or directory at the specified URL.
  ///
  /// Prior to removing each item, the file manager asks its delegate if it should actually do so.
  /// It does this by calling the fileManager(_:shouldRemoveItemAt:) method; if that method is
  /// not implemented (or the process is running in OS X 10.5 or earlier) it calls the
  /// fileManager(_:shouldRemoveItemAtPath:) method instead. If the delegate method returns true, or
  /// if the delegate does not implement the appropriate methods, the file manager proceeds to remove
  /// the file or directory. If there is an error removing an item, the file manager may also call the
  /// delegate’s fileManager(_:shouldProceedAfterError:removingItemAt:) or
  /// fileManager(_:shouldProceedAfterError:removingItemAtPath:) method to determine how to proceed.
  /// - parameter URL: A file URL specifying the file or directory to remove. If the URL specifies a
  /// directory, the contents of that directory are recursively removed.
  func removeItem(at URL: URL) throws

  /// Performs a shallow search of the specified directory and returns URLs for the contained items.
  /// - Parameters:
  ///   - url: The URL for the directory whose contents you want to enumerate.
  ///   - keys: An array of keys that identify the file properties that you want pre-fetched for each
  ///   item in the directory. For each returned URL, the specified properties are fetched and cached
  ///   in the NSURL object. For a list of keys you can specify, see Common File System Resource Keys.
  ///   If you want directory contents to have no pre-fetched file properties, pass an empty array to
  ///   this parameter. If you want directory contents to have default set of pre-fetched file
  ///   properties, pass nil to this parameter.
  ///   - mask: Options for the enumeration. Because this method performs only shallow enumerations,
  ///   options that prevent descending into subdirectories or packages are not allowed; the only
  ///   supported option is skipsHiddenFiles.
  /// - Returns: An array of NSURL objects, each of which identifies a file, directory, or symbolic
  /// link contained in url. If the directory contains no entries, this method returns an empty array.
  func contentsOfDirectory(
    at url: URL,
    includingPropertiesForKeys keys: [URLResourceKey]?,
    options mask: FileManager.DirectoryEnumerationOptions
  ) throws -> [URL]
}
