//
//  AppErrorValidation.swift
//  TaskNest
//
//  Created by Tung Le on 14/6/2025.
//

import Foundation

enum ValidationError: LocalizedError {
  case emptyEmail
  case invalidEmailFormat
  case emptyPassword
  case tooShortPassword(min: Int)
  case missingUppercase
  case missingNumber
  case passwordMismatch
  case tooShortUsername(min: Int)
  
  /// new for creating task item
  case emptyTitle
  case unknown
  
  
  var errorDescription: String? {
    switch self {
    case .emptyEmail:
      return "Email is required."
    case .invalidEmailFormat:
      return "Email format is invalid."
    case .emptyPassword:
      return "Password is required."
    case .tooShortPassword(let min):
      return "Password must be at least \(min) characters."
    case .missingUppercase:
      return "Password must contain an uppercase letter."
    case .missingNumber:
      return "Password must contain a number."
    case .passwordMismatch:
          return "Passwords do not match."
    case .tooShortUsername(min: let min):
      return "Username must be at least 6 characters."
    case .emptyTitle:
      return "Title must not be empty"
    case .unknown:
      return "Unkown validation error"
    }
  }
  
  var description: String {
    return errorDescription ?? ""
  }
}
