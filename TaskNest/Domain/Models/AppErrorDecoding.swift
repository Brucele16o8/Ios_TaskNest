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
  case keyNotFound(key: String, context: String)
  case valueNotFound(type: String, context: String)
  case typeMismatch(expected: String, context: String)
  case dataCorrupted(context: String)
  case invalidDataFormat(reason: String)
  case unknown(message: String)
  
  public var errorDescription: String? {
    switch self {
    case .cannotDecodeRawData:
      return "Cannot decode raw data from server"
    case .cannotDecodeContentData:
      return "Cannot decode content data from server"
    case .cannotParseResponse:
      return "Server response could not be parsed"
      
    case .keyNotFound(key: let key, context: _):
      return "Missing key: \(key)"
    case.valueNotFound(type: let type, context: let context):
      return "DecodingError.valueNotFound: \(type) | Context: \(context)"
    case .typeMismatch(expected: let expected, context: _):
      return "Type mismatch. Expected type: \(expected)"
    case .dataCorrupted(context: _):
      return "Corrupted or unreadable data"
    case .invalidDataFormat(reason: let reason):
      return "Invalid data format: \(reason)"
    case .unknown(message: let message):
      return "Unknown decoding issue: \(message)"
    }
  }
  
  public var debugDescription: String {
    switch self {
    case .cannotDecodeRawData:
      return ".cannotDecodeRawData - Cannot decode raw data from server"
    case .cannotDecodeContentData:
      return ".cannotDecodeContentData - Cannot decode content data from server"
    case .cannotParseResponse:
      return ".cannotParseResponse - Server response could not be parsed"
      
    case .keyNotFound(key: let key, context: let context):
      return ".keyNotFound: Key: \(key) | Context: \(context)"
      
    case.valueNotFound(type: let type, context: let context):
      return ".valueNotFound: Type: \(type) | Context: \(context)"
      
    case .typeMismatch(expected: let expected, context: let context):
      return ".typeMismatch: Expected type: \(expected) | Context: \(context)"
      
    case .dataCorrupted(context: let context):
      return ".dataCorrupted | Context: \(context)"
      
    case .invalidDataFormat(reason: let reason):
      return ".invalidDataFormat: reason \(reason)"
      
    case .unknown(message: let message):
      return "Unknown decoding issue: \(message)"
    }
  }
  
}
