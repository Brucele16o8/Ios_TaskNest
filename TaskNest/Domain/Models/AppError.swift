//
//  AppError.swift
//  TaskNest
//
//  Created by Tung Le on 10/6/2025.
//

import Foundation
import Auth0

enum AppError: Error, LocalizedError {
  case auth(AppErrorAuth, underlyingError: Error? = nil)
  case network(AppErrorNetwork, underlyingError: Error? = nil)
  case decoding(AppErrorDecoding, underlyingError: Error? = nil)
  case encoding(AppErrorEncoding, underlyingError: Error? = nil)
  case validation(ValidationError, underlyingError: Error? = nil)
  case database(DatabaseError, underlyingError: Error? = nil)
  case unknown(message: String, underlyingError: Error? = nil)
  
  // ✅
  public var errorDescription: String? {
    switch self {
      
    case .auth(let authError, _):
      return authError.localizedDescription
      
    case .network(let networkError, _):
      return networkError.localizedDescription
      
    case .decoding(let decodingError, _):
      return decodingError.localizedDescription
      
    case .encoding(let encodingError, _):
      return encodingError.localizedDescription
      
    case .validation(let validationError, _):
      return validationError.localizedDescription
      
    case .database(let databaseError, underlyingError: _):
      return databaseError.localizedDescription
      
    case .unknown(let message, _):
      return "Unexpected error - error: \(message)"
    }
  }
  
  // ✅
  public var debugDescription: String {
    switch self {
    case .auth(let authError, let underlyingError):
      return "[Auth] \(authError.debugDescription)" + underlyingInfo(underlyingError)
      
    case .network(let networkError, let underlyingError):
      return "[Network] \(networkError.debugDescription)" + underlyingInfo(underlyingError)
      
    case .decoding(let message, let underlyingError):
      return "[Decoding] \(message)" + underlyingInfo(underlyingError)
      
    case .encoding(let message, let underlyingError):
      return "[Encoding] \(message)" + underlyingInfo(underlyingError)
      
    case .validation(let validationError, let underlyingError):
      return "[Validation] \(validationError.localizedDescription)" + underlyingInfo(underlyingError)
      
    case .database(let DatabaseError, underlyingError: let underlyingError):
      return "[Database] \(DatabaseError.localizedDescription)" + underlyingInfo(underlyingError)
      
    case .unknown(message: let message, let underlyingError):
      return "[Unknown] \(message)" + underlyingInfo(underlyingError)
    }
  }
  
  
  // Helper method
  private func underlyingInfo(_ error: Error?) -> String {
    guard let error = error else { return "" }
    let typeName = String(reflecting: type(of: error)) // to get the full type name of the error
    var message = " | System: [--\(typeName)--] - \(error.localizedDescription)"
    
    /// Special handling for WebAuthError.cause for deeper error
    if let webAuthError = error as? WebAuthError, let causeError = webAuthError.cause {
      message += "\n   ↪︎ RootCause: [\(type(of: causeError))] - \(causeError.localizedDescription)"
    }
    
    /// Special handling for CredentialsManagerError.cause
    if let credentialsError = error as? CredentialsManagerError, let causeError = credentialsError.cause {
      message += "\n   ↪︎ RootCause: [\(type(of: causeError))] - \(causeError.localizedDescription)"
    }
    
    return message
  }
  
}




