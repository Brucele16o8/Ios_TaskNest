//
//  Untitled.swift
//  TaskNest
//
//  Created by Tung Le on 10/6/2025.
//

import Foundation

enum AppErrorNetwork: LocalizedError {
  case timeout
  case unreachable(code: URLError.Code)
  case unauthorized
  case unknown(message: String)
  
  public var errorDescription: String? {
    switch self {
    case .timeout: 
      return "Request timed out."
      
    case .unreachable(let code):
      return "Network is unreachable: Code - \(code.rawValue) - \(code)"
      
    case .unauthorized:
      return "Unauthorized access."
      
    case .unknown(let message):
      return "Network Error: \(message)"
    }
  }
  
  
  public var debugDescription: String {
    switch self {
    case .timeout:
      return "Time out"
      
    case .unreachable(let code):
      return "Network is unreachable: Code - \(code.rawValue) - \(code)"
      
    case .unauthorized:
      return "401 Unauthorized – Token missing or expired"
      
    case .unknown(let message):
      return "Unkown network issue: \(message)"
    }
  }
}
