//
//  AppErrorEncoding.swift
//  TaskNest
//
//  Created by Tung Le on 26/6/2025.
//

import Foundation

enum AppErrorEncoding: LocalizedError {
  // JSON encoder-specific errors
  case invalidTopLevelObject
  case unableToEncodeValue(type: Any.Type)
  case encodingFailed(context: EncodingError.Context)
  
  /// fallback or unexpected
  case unknown(message: String)

  // 🧩
  public var errorDescription: String? {
    switch self {
    case .invalidTopLevelObject:
      return "Top-level value is nil or not encodable to JSON"
    case .unableToEncodeValue(let type):
      return "Unable to encode value of type \(type)"
    case .encodingFailed(let context):
      return "Encoding failed: \(context.debugDescription)"
    case .unknown(let message):
      return "Unknown encoding issue: \(message)"
    }
  }

  // 🧩
  public var debugDescription: String {
    switch self {
    case .invalidTopLevelObject:
      return ".invalidTopLevelObject - Top-level value is nil or not a valid JSON object"

    case .unableToEncodeValue(let type):
      return ".unableToEncodeValue - Failed to encode value of type: \(type)"

    case .encodingFailed(let context):
      return ".encodingFailed - Context: \(context.debugDescription)"

    case .unknown(let message):
      return ".unknown - Unknown encoding issues: \(message)"
    }
  }
}

