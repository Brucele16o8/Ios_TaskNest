//
//  AppErrorImage.swift
//  TaskNest
//
//  Created by Tung Le on 16/7/2025.
//

import Foundation

enum ImageError: Error, LocalizedError, Sendable, Equatable {
  
  case conversionFailed
  case saveFailed(reason: String? = nil)
  case loadFailed(path: String? = nil)
  case resizeFailed
  case invalidData
  case fileNotFound(path: String? = nil)
  case cachedFolderCreationFailed(path: String? = nil)
  case unknown
  
  // 🧩
  var errorDescription: String? {
    switch self {
    case .conversionFailed:
      return "Failed to convert image to JPEG format."
    case .saveFailed(let reason):
      return "Failed to save image to disk."
    case .loadFailed(let path):
      return "Failed to load image."
    case .resizeFailed:
      return "Failed to resize image."
    case .invalidData:
      return "The image data is corrupted or unsupported."
    case .fileNotFound(let path):
      return "The image file could not be found."
    case .cachedFolderCreationFailed:
      return "Failed to create photo_cache directory"
    case .unknown:
      return "An unknown image error occurred."
    }
  }
  
  // 🧩
  var debugDescription: String {
    switch self {
    case .conversionFailed:
      return ".conversionFailed - Failed to convert image to JPEG format."
    case .saveFailed(let reason):
      return ".saveFailed - Failed to save image to disk. \(reason ?? "")"
    case .loadFailed(let path):
      return ".loadFailed - Failed to load image from path: \(path ?? "unknown")"
    case .resizeFailed:
      return ".resizeFailed - Failed to resize image."
    case .invalidData:
      return ".invalidData - The image data is corrupted or unsupported."
    case .fileNotFound(let path):
      return ".fileNotFound - The image file could not be found: \(path ?? "unknown")"
    case .cachedFolderCreationFailed(path: let path):
      return ".cachedFolderCreationFailed - Failed to create photo_cache directory at path: \(path ?? "unknown")"
    case .unknown:
      return "An unknown image error occurred."
    }
  }
  
  
  
} // 🧱
