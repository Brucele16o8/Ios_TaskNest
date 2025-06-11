//
//  errorDescription.swift
//  TaskNest
//
//  Created by Tung Le on 11/6/2025.
//

import Foundation

public enum AppErrorDecoding: LocalizedError {
  case cannotDecodeRawData
  case cannotDecodeContentData
  case cannotParseResponse
  
  // handle JSON decoder error
  case keyNotFound(key: CodingKey, context: DecodingError.Context)
  case valueNotFound(type: Any.Type, context: DecodingError.Context)
  case typeMismatch(expectedType: Any.Type, context: DecodingError.Context)
  case dataCorrupted(context: DecodingError.Context)

  /// others
  case unknown(message: String)
  
  // 🧩
  public var errorDescription: String? {
    switch self {
      /// handle decoding error from Auth0
    case .cannotDecodeRawData:
      return "Cannot decode raw data from server"
    case .cannotDecodeContentData:
      return "Cannot decode content data from server"
    case .cannotParseResponse:
      return "Server response could not be parsed"
      
      /// handle JSON decoder error
    case .keyNotFound(key: let key, context: _):
      return "Missing key: \(key.stringValue)"
    case.valueNotFound(type: let type, context: let context):
      return "DecodingError.valueNotFound: \(type) | Context: \(context.debugDescription)"
    case .typeMismatch(expectedType: let expectedType, context: _):
      return "Type mismatch. Expected type: \(expectedType)"
    case .dataCorrupted(context: _):
      return "Corrupted or unreadable data"
      
      /// others
    case .unknown(message: let message):
      return "Unknown decoding issue: \(message)"
    }
  }
  
  // 🧩
  public var debugDescription: String {
    switch self {
      /// handle decoding error from Auth0
    case .cannotDecodeRawData:
      return ".cannotDecodeRawData - Cannot decode raw data from server"
    case .cannotDecodeContentData:
      return ".cannotDecodeContentData - Cannot decode content data from server"
    case .cannotParseResponse:
      return ".cannotParseResponse - Server response could not be parsed"
      
      /// handle JSON decoder error
    case .keyNotFound(key: let key, context: let context):
      return ".keyNotFound: Key: \(key.stringValue) | Context: \(context.debugDescription)"
      
    case.valueNotFound(type: let type, context: let context):
      return ".valueNotFound: Type: \(type) | Context: \(context.debugDescription)"
      
    case .typeMismatch(expectedType: let expectedType, context: let context):
      return ".typeMismatch: Expected type: \(expectedType) | Context: \(context.debugDescription)"
      
    case .dataCorrupted(context: let context):
      return ".dataCorrupted | Context: \(context.debugDescription)"
      
      /// others
    case .unknown(message: let message):
      return "Unknown decoding issue: \(message)"
    }
  }
  
}
