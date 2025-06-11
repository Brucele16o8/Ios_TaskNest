//
//  ErrorMapper.swift
//  TaskNest
//
//  Created by Tung Le on 10/6/2025.
//

import Foundation
import Auth0

struct ErrorMapper {
  
  // ✅
  static func mapWebAuthError(_ webAuthError: WebAuthError) -> AppError {
    switch webAuthError {
    case .userCancelled:
      return .auth(.cancelled, underlyingError: webAuthError)

    case .transactionActiveAlready:
      return .auth(.unknown(message: "Transaction already active"), underlyingError: webAuthError)
      
    case .noBundleIdentifier:
      return .auth(.unknown(message: "Missing bundle identifier"), underlyingError: webAuthError)
      
    case .invalidInvitationURL:
      return .auth(.unknown(message: "Invalid invitation URL"), underlyingError: webAuthError)
      
    case .noAuthorizationCode:
      return .auth(.unknown(message: "No Authorization code in callback"), underlyingError: webAuthError)
      
    case .pkceNotAllowed:
      return .auth(.unknown(message: "PKCE not allowed"), underlyingError: webAuthError)
      
    case .idTokenValidationFailed:
      return .auth(.unknown(message: "ID token validation failed"), underlyingError: webAuthError)
      
    case .other:
      return .auth(.unknown(message: "Unexpected Auth0 error"), underlyingError: webAuthError)
      
    case .unknown:
      return .auth(.unknown(message: "Unknown Auth0 error"), underlyingError: webAuthError)
      
    default:
      return .auth(.unknown(message: "Unknown Auth0 error"), underlyingError: webAuthError)
    }




  }
  
  /// ✅
  static func mapURLError(_ error: URLError, original: Error) -> AppError {
      switch error.code {
      case .cancelled:
          return .auth(.cancelled, underlyingError: original)
      case .notConnectedToInternet:
          return .auth(.noInternet, underlyingError: original)
      case .timedOut:
          return .network(.timeout, underlyingError: original)
      case .cannotConnectToHost:
          return .network(.unreachable(code: .cannotConnectToHost), underlyingError: original)
      case .cannotFindHost:
          return .network(.unreachable(code: .cannotFindHost), underlyingError: original)
      case .dnsLookupFailed:
          return .network(.unreachable(code: .dnsLookupFailed), underlyingError: original)
      case .networkConnectionLost:
          return .network(.unreachable(code: .networkConnectionLost), underlyingError: original)
      case .httpTooManyRedirects:
          return .network(.unreachable(code: .httpTooManyRedirects), underlyingError: original)
      case .resourceUnavailable:
          return .network(.unreachable(code: .resourceUnavailable), underlyingError: original)
      case .redirectToNonExistentLocation:
          return .network(.unreachable(code: .redirectToNonExistentLocation), underlyingError: original)
      case .unsupportedURL:
          return .network(.unreachable(code: .unsupportedURL), underlyingError: original)
      case .badURL:
          return .network(.unreachable(code: .badURL), underlyingError: original)
      case .badServerResponse:
          return .network(.unreachable(code: .badServerResponse), underlyingError: original)
      case .userCancelledAuthentication:
          return .network(.unreachable(code: .userCancelledAuthentication), underlyingError: original)
      case .userAuthenticationRequired:
          return .network(.unauthorized, underlyingError: original)
      case .zeroByteResource:
          return .network(.unreachable(code: .zeroByteResource), underlyingError: original)
      case .cannotDecodeRawData:
          return .decoding(.cannotDecodeRawData, underlyingError: original)
      case .cannotDecodeContentData:
          return .decoding(.cannotDecodeContentData, underlyingError: original)
      case .cannotParseResponse:
          return .decoding(.cannotParseResponse, underlyingError: original)
      default:
          return .network(.unknown(message: error.localizedDescription), underlyingError: original)
      }
  }
}
