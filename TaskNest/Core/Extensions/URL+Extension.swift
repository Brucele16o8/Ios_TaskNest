//
//  URL+Extension.swift
//  TaskNest
//
//  Created by Tung Le on 16/7/2025.
//

import Foundation

extension URL {
  static func photoCacheDirectory() throws -> URL {
    let folder = URL.documentsDirectory.appending(path: "photo_cache")
    do {
      try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
      return folder
    } catch {
      throw AppError.image(.cachedFolderCreationFailed(path: folder.path), underlyingError: error)
    }
  }
  
} // 🧱
