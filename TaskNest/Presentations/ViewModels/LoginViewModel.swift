//
//  LoginViewModel.swift
//  TaskNest
//
//  Created by Tung Le on 14/6/2025.
//

import Foundation
import Auth0

@MainActor
final class LoginViewModel: ObservableObject {
  @Published private var loginState = LoginUIState()
  @Published private var appError: AppError?
  
  var state: LoginUIState { loginState }
  var error: AppError? { appError }
  
  private let loginUseCase: LoginUseCase
  private var credentials: Credentials?
  
  init(loginUseCase: LoginUseCase) {
    self.loginUseCase = loginUseCase
    restoreSession()
  }
  
  ///  - Restore session
  func restoreSession() {
    loginUseCase.restore { [weak self] result in
      if case .success(let credentials) = result {
        self?.credentials = credentials
        self?.loginState.status = .authenticated
      }
    }
  }
  
  // ✅ Login with email and password
  func loginWithEmailAndPassword() {
    guard validateInput() else { return }
    
    loginState.status = .authenticating
    appError = nil
    
    loginUseCase.loginWithEmailAndPassword(
      email: loginState.email,
      password: loginState.password
    ) { [weak self] result in
      self?.handleLoginResult(result)
    }
  }
  
  // ✅ Login with Google
  func loginWithGoogle() {
    loginState.status = .authenticating
    appError = nil
    
    loginUseCase.loginWithGoogle() { [weak self] result in
      self?.handleLoginResult(result)
    }
  }
  
  // ✅ Logout
  func logout() {
    loginUseCase.logout()
    loginState = LoginUIState()
    appError = nil
  }
  
  /// ✅ -  Helper method
  private func handleLoginResult(_ result: Result<Credentials, Error>) {
    Task { @MainActor in
      switch result {
      case .success(let credentials):
        self.credentials = credentials
        loginState.status = .authenticated
      case .failure(let error):
        appError = error.toAppError
        loginState.status = .error
      }
    }
  }
  
  ///  - Validation
  private func validateInput() -> Bool {
    if loginState.email.isEmpty {
      appError = ValidationError.emptyEmail.toAppError
      return false
    }
    if !loginState.email.contains("@") {
      appError = ValidationError.invalidEmailFormat.toAppError
      return false
    }
    if loginState.password.isEmpty {
      appError = ValidationError.invalidEmailFormat.toAppError
      return false
    }
    if loginState.password.count < 8 {
      appError = ValidationError.tooShortPassword(min: PasswordConfig.minLength).toAppError
      return false
    }
    
    return true
  }
  
} // 🧱
