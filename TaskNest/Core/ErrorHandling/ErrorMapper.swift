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
  
  
  // ✅
  static func mapCredentialsManagerError(_ error: CredentialsManagerError) -> AppError {
      switch error {
      case .noCredentials:
          return .auth(.unauthorized(message: "No credentials found"), underlyingError: error)

      case .noRefreshToken:
          return .auth(.unauthorized(message: "Missing refresh token"), underlyingError: error)

      case .renewFailed:
          return .auth(.unauthorized(message: "Failed to renew credentials"), underlyingError: error)
        
      case .apiExchangeFailed:
          return .auth(.unauthorized(message: "API exchange failed"), underlyingError: error)

      case .ssoExchangeFailed:
          return .auth(.unauthorized(message: "SSO exchange failed"), underlyingError: error)

      case .storeFailed:
          return .auth(.unknown(message: "Failed to store credentials"), underlyingError: error)

      case .biometricsFailed:
          return .auth(.unauthorized(message: "Biometric authentication failed"), underlyingError: error)

      case .revokeFailed:
          return .auth(.unknown(message: "Failed to revoke credentials"), underlyingError: error)

      case .largeMinTTL:
          return .auth(.unknown(message: "Requested minTTL exceeds token lifetime"), underlyingError: error)
        
      default:
          return .auth(.unknown(message: "Unkown Auth0 error"), underlyingError: error)

      }
  }

  
  // ✅
  static func mapURLError(_ error: URLError, originalError: Error) -> AppError {
      switch error.code {
      case .cancelled:
          return .auth(.cancelled, underlyingError: originalError)
      case .notConnectedToInternet:
          return .auth(.noInternet, underlyingError: originalError)
      case .timedOut:
          return .network(.timeout, underlyingError: originalError)
      case .cannotConnectToHost:
          return .network(.unreachable(code: .cannotConnectToHost), underlyingError: originalError)
      case .cannotFindHost:
          return .network(.unreachable(code: .cannotFindHost), underlyingError: originalError)
      case .dnsLookupFailed:
          return .network(.unreachable(code: .dnsLookupFailed), underlyingError: originalError)
      case .networkConnectionLost:
          return .network(.unreachable(code: .networkConnectionLost), underlyingError: originalError)
      case .httpTooManyRedirects:
          return .network(.unreachable(code: .httpTooManyRedirects), underlyingError: originalError)
      case .resourceUnavailable:
          return .network(.unreachable(code: .resourceUnavailable), underlyingError: originalError)
      case .redirectToNonExistentLocation:
          return .network(.unreachable(code: .redirectToNonExistentLocation), underlyingError: originalError)
      case .unsupportedURL:
          return .network(.unreachable(code: .unsupportedURL), underlyingError: originalError)
      case .badURL:
          return .network(.unreachable(code: .badURL), underlyingError: originalError)
      case .badServerResponse:
          return .network(.unreachable(code: .badServerResponse), underlyingError: originalError)
      case .userCancelledAuthentication:
          return .network(.unreachable(code: .userCancelledAuthentication), underlyingError: originalError)
      case .userAuthenticationRequired:
          return .network(.unauthorized, underlyingError: originalError)
      case .zeroByteResource:
          return .network(.unreachable(code: .zeroByteResource), underlyingError: originalError)
      case .cannotDecodeRawData:
          return .decoding(.cannotDecodeRawData, underlyingError: originalError)
      case .cannotDecodeContentData:
          return .decoding(.cannotDecodeContentData, underlyingError: originalError)
      case .cannotParseResponse:
          return .decoding(.cannotParseResponse, underlyingError: originalError)
      default:
          return .network(.unknown(message: error.localizedDescription), underlyingError: originalError)
      }
  }
  
  // ✅
  static func mapJsonDecodingError(_ decodingError: DecodingError) -> AppError {
    let parsed = JsonDecodingErrorParser.parse(decodingError)
    return .decoding(parsed, underlyingError: decodingError)
  }
  
  // ✅
  static func mapAuthenticationError(_ authenticationError: AuthenticationError) -> AppError {
    return .auth(.unauthenticated(message: "Code: \(authenticationError.code)"), underlyingError: authenticationError)
  }

  
}
