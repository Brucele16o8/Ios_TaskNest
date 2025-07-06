//
//  AuthManager.swift
//  TaskNest
//
//  Created by Tung Le on 9/6/2025.
//

import Foundation
import Auth0
import Observation

@MainActor
@Observable
final class AuthManager {
  // ✅ Type
  enum AuthState: Equatable {
    case checking
    case authenticating
    case authenticated
    case unauthenticated
  }
  
  var authState: AuthState = .checking
  private let loginUseCase: AuthUseCase
  private var credentials: Credentials?
  private(set) var currentUser: AuthenticatedUser?
  
  init(loginUseCase: AuthUseCase) {
    self.loginUseCase = loginUseCase
    checkSession()
    }
  
  var authToken: String {
    get throws {
      guard let credentials else {
        throw AppError.auth(.unknown(message: "Failed to get auth token from stored credentials in AuthManager"))
      }
      return credentials.accessToken
    }
  }
  
  /// Checking session
  func checkSession() {
    loginUseCase.restore { [weak self] result in
      Task { @MainActor in
          switch result {
          case .success:
            self?.authState = .authenticated
          case .failure:
            self?.authState = .unauthenticated
        }
      }
    }
  }
  
  // ✅ Store / Cache credentials
  func storeCredentials(_ credentials: Credentials) {
    self.credentials = credentials
  }
  
  func storeAuthenticatedUser(_ user: AuthenticatedUser) {
      self.currentUser = user
    }
  
  // ✅
  func updateAuthStateIfNeeded(from loginStatus: LoginStatus) {
    switch loginStatus {
    case .authenticated:
      authState = AuthState.authenticated
    case .authenticating:
      authState = AuthState.authenticating
    case .idle, .error:
      authState = AuthState.unauthenticated
    }
  }
  
} // 🧱

