//
//  AppError.swift
//  TaskNest
//
//  Created by Tung Le on 10/6/2025.
//

import Foundation

public enum AppError: Error, LocalizedError {
  case auth(AppErrorAuth)
  case network(AppErrorNetwork)
  case decoding(message: String)
  case unknown(message: String)
  
  public var errorDescription: String? {
    switch self {
      
    case .auth(let authError):
      return authError.localizedDescription
      
    case .network(let networkError):
      return networkError.localizedDescription
      
    case .decoding(let message): 
      return "Decoding failed - error: \(message)"
      
    case .unknown(let message): 
      return "Unexpected error - error: \(message)"
    }
  }
}




