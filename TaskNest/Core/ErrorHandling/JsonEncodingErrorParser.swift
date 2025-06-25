//
//  JsonEncodingErrorParser.swift
//  TaskNest
//
//  Created by Tung Le on 26/6/2025.
//

import Foundation

enum JsonEncodingErrorParser {
  
  static func parse(_ error: EncodingError) -> AppErrorEncoding {
    switch error {
    case .invalidValue(let value, let context):      
      // Case: trying to encode nil as the top-level object
      if context.codingPath.isEmpty {
        return .invalidTopLevelObject
      }
      
      // Case: common problematic types
      if value is URL {
        return .unableToEncodeValue(type: URL.self)
      }
      if value is Date {
        return .unableToEncodeValue(type: Date.self)
      }
      
      // Fallback with full context
      return .encodingFailed(context: context)

    @unknown default:
      return .unknown(message: "Unknown future EncodingError case")
    }
  }
}

