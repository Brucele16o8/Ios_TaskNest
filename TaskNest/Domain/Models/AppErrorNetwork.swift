//
//  Untitled.swift
//  TaskNest
//
//  Created by Tung Le on 10/6/2025.
//

import Foundation

public enum AppErrorNetwork: LocalizedError {
  case timeout
  case unreachable
  case unauthorized
  case unknown(message: String)
  
  public var errorDescription: String? {
    switch self {
    case .timeout: return "Request timed out."
    case .unreachable: return "Network is unreachable."
    case .unauthorized: return "Unauthorized access."
    case .unknown(let msg): return msg
    }
  }
}
