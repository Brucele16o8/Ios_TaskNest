//
//  JsonDecodingParser.swift
//  TaskNest
//
//  Created by Tung Le on 12/6/2025.
//

enum JsonDecodingErrorParser {
  
  // ✅
  static func parse(_ error: DecodingError) -> AppErrorDecoding {
    switch error {
    case .keyNotFound(let key, let context):
      return .keyNotFound(key: key, context: context)
      
      case .valueNotFound(let type, let context):
      return .valueNotFound(type: type, context: context)
      
    case .typeMismatch(let expectedType, let context):
      return .typeMismatch(expectedType: expectedType, context: context)
      
    case .dataCorrupted(let context):
      return .dataCorrupted(context: context)
      
    @unknown default:
      return .unknown(message: "Unkown Default future error")
    }
  }
  
}
