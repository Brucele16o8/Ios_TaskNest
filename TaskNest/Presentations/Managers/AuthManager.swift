//
//  AuthManager.swift
//  TaskNest
//
//  Created by Tung Le on 9/6/2025.
//

import Foundation
import Auth0

@MainActor
final class AuthManager: ObservableObject {
  // ✅ Type
  enum AuthState {
    case checking
    case authenticating
    case authenticated
    case unauthenticated
  }
  
  @Published var authState: AuthState = .checking
  private let loginUseCase: LoginUseCase
  
  init(loginUseCase: LoginUseCase) {
    self.loginUseCase = loginUseCase
    checkSession()
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

