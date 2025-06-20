//
//  LoginViewModel.swift
//  TaskNest
//
//  Created by Tung Le on 14/6/2025.
//

import Foundation
import Auth0
import SwiftUI
import Combine

@MainActor
@Observable
final class LoginViewModel {
  // MARK: - State
  private var loginState = LoginUIState()
  private var appError: AppError?
  
  var state: LoginUIState { loginState }
  var error: AppError? { appError }
  
  // MARK: - Dependencies
  private let loginUseCase: LoginUseCase
  private var credentials: Credentials?
  
  // MARK: - Computed
  var isValidLoginForm: Bool {
    loginState.isValidLoginForm
  }
  
  
  init(loginUseCase: LoginUseCase) {
    self.loginUseCase = loginUseCase
//    bindValidation()
    restoreSession()
  }
  
  // ✅
  func updateEmail(_ email: String) {
    loginState.email = email
  }
  
  // ✅
  func updatePassword(_ password: String) {
    loginState.password = password
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
    let result = validateInput(email: loginState.email, password: loginState.password)
    appError = result.appError
    guard result.isValid else { return }
    
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
  private func validateInput(email: String, password: String) -> (isValid: Bool, appError: AppError?) {
    let rules: [(Bool, ValidationError)] = [
      (email.isEmpty, .emptyEmail),
      (email.contains("@"), .invalidEmailFormat),
      (password.isEmpty, .emptyPassword),
      (password.count < PasswordConfig.minLength, .tooShortPassword(min: PasswordConfig.minLength)),
      (!password.contains(where: \.isUppercase), .missingUppercase),
      (!password.contains(where: \.isNumber) , .missingNumber)
    ]
    
    for (failed, validationError) in rules {
      if failed {
        return (false, validationError.toAppError)
      }
    }
    
    return (true, nil)
  }
  
  ///  - Animation
  func startAnimation() {
    Task {
      try? await Task.sleep(nanoseconds: 300_000_000)
      withAnimation(.easeOut(duration: 1)) {
        loginState.showText = true
      }
    }
  }
  
} // 🧱
