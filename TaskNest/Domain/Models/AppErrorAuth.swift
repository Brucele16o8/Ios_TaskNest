//
//  Untitled.swift
//  TaskNest
//
//  Created by Tung Le on 10/6/2025.
//

import Foundation

public enum AppErrorAuth: LocalizedError {
  case cancelled
  case noInternet
  case invalidCredentials
  case unknown(message: String)
  
  public var errorDescription: String? {
    switch self {
    case .cancelled:
      return "Login was cancelled"
      
    case .noInternet:
      return "No internet connection."
      
    case .invalidCredentials: 
      return "Invalid credentials - please check your email or password"
      
    case .unknown(let message):
      return "Auth error \(message)"
    }
  }
  
  public var debugDescription: String {
    switch self {
    case .cancelled:
      return "User cancelled the login process."
      
    case .noInternet:
      return "No internet connection available."
      
    case .invalidCredentials:
      return "Invalid credentials provided"
      
    case .unknown(let message):
      return "Unknown authentication error: \(message)"
    }
  }
  
}

