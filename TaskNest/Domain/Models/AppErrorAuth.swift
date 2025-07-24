//
//  Untitled.swift
//  TaskNest
//
//  Created by Tung Le on 10/6/2025.
//

import Foundation

enum AppErrorAuth: LocalizedError {
  case cancelled
  case noInternet
  case invalidCredentials
  case unauthorized(message: String)
  case unauthenticated(message: String)
  
  /// for the case of creating new task item
  case userNotFound
  
  case unknown(message: String)
  
  // 🧩
  public var errorDescription: String? {
    switch self {
    case .cancelled:
      return "Login was cancelled"
      
    case .noInternet:
      return "No internet connection."
      
    case .invalidCredentials:
      return "Invalid credentials - please check your email or password"
      
    case .unauthorized(message: let message):
      return "Unauthorized - \(message)"
      
    case .unauthenticated(message: let message):
      return "Authentication error - \(message)"
      
    case .userNotFound:
      return "User not found"
      
    case .unknown(let message):
      return "Auth error \(message)"
    }
  }
  
  // 🧩
  public var debugDescription: String {
    switch self {
    case .cancelled:
      return "User cancelled the login process."
      
    case .noInternet:
      return "No internet connection available."
      
    case .invalidCredentials:
      return "Invalid credentials provided"
      
    case .unauthorized(message: let message):
      return "Unauthorized access - \(message)"
      
    case .unauthenticated(message: let message):
      return "Authentication error - \(message)"
      
    case .userNotFound:
      return "User or userId not found"
      
    case .unknown(let message):
      return "Unknown authentication error: \(message)"
    }
  }
  
}

