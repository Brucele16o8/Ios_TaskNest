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
  private var loginUiState: LoginUIState = LoginUIState()
  var state: LoginUIState { loginUiState }
  
  // MARK: - Dependencies
  private let authUseCase: AuthUseCase
  private var authManager: AuthManager
  private let appCoordinator: AppCoordinator
  
  // MARK: - Computed
  var isValidLoginForm: Bool {
    loginUiState.isValidLoginForm
  }
  
  // MARK: - INIT
  init(authUseCase: AuthUseCase, authManager: AuthManager, appCoordinator: AppCoordinator) {
    self.authUseCase = authUseCase
    self.authManager = authManager
    self.appCoordinator = appCoordinator
  }
  
  // ✅
  func updateEmail(_ email: String) {
    loginUiState.email = email
    
    if email.isEmpty {
      loginUiState.emailError = "Email cannot be empty."
    } else if !email.contains("@") {
      loginUiState.emailError = "Invalid email format."
    } else {
      loginUiState.emailError = ""
    }
  }
  
  // ✅
  func updatePassword(_ password: String) {
    loginUiState.password = password
    
    if password.isEmpty {
      loginUiState.passwordError = "Password cannot be empty."
    } else if password.count < SignUpLoginConfig.passwordMinLength {
      loginUiState.passwordError = "Password too short (min \(SignUpLoginConfig.passwordMinLength))"
    } else if !password.contains(where: \.isUppercase) {
      loginUiState.passwordError = "Password must contain an uppercase letter."
    } else if !password.contains(where: \.isNumber) {
      loginUiState.passwordError = "Password must contain a number."
    } else {
      loginUiState.passwordError = ""
    }
  }
  
  // ✅ Login with email and password
  func loginWithEmailAndPassword() async {
    Logger.d(tag: "Login", message: "Inside LoginViewModel - loginWithEmailAndPassword")
    
    loginUiState.status = .authenticating
    loginUiState.errorMessage = nil
    
    Logger.d(tag: "Login", message: "emai: \(loginUiState.email), password: \(loginUiState.password)")
    
    guard loginUiState.isValidLoginForm else {
      Logger.e(tag: "LoginViewModel", message: "Invalid form")
      loginUiState.status = .idle
      return
    }
    
    do {
      let credentials = try await authUseCase.loginWithEmailAndPassword(email: loginUiState.email, password: loginUiState.password)
      authManager.storeCredentials(credentials)
      let authenticatedUser = try await authUseCase.getUserInfo(acceessToken: authManager.authToken)
      authManager.storeAuthenticatedUser(authenticatedUser)
      loginUiState.status = .authenticated
      Logger.d(tag: "LoginViewModel", message: "Before setRootRoute - current path: \(appCoordinator.navigationPath)")
      appCoordinator.setRootRoute(.main)
      Logger.d(tag: "LoginViewModel", message: "Login successful with token: ...\(credentials.accessToken.suffix(10))")
      Logger.d(tag: "LoginViewModel", message: "After setRootRoute - current path: \(appCoordinator.navigationPath)")
    }
    catch {
      var appError: AppError
      if case let error as AppError = error {
        appError = error
      } else {
        appError = ErrorMapper.map(error)
      }
      
      loginUiState.status = .error(appError)
      loginUiState.errorMessage = appError.localizedDescription
      Logger.e(tag: "LoginViewModel", message: "Login failed: \(appError.debugDescription)")
    }
  }
  
  // ✅ Login with Google
  func loginWithGoogle() async {
    loginUiState.status = .authenticating
    loginUiState.errorMessage = nil
    
    do {
      let credentials = try await authUseCase.loginWithGoogle()
      authManager.storeCredentials(credentials)
      let authenticatedUser = try await authUseCase.getUserInfo(acceessToken: authManager.authToken)
      authManager.storeAuthenticatedUser(authenticatedUser)
      loginUiState.status = .authenticated
      appCoordinator.setRootRoute(.main)
      Logger.d(tag: "LoginViewModel", message: "Google login successful with token: \(credentials.accessToken.suffix(10))")
    }
    catch {
      var appError: AppError
      if case let error as AppError = error {
        appError = error
      } else {
        appError = ErrorMapper.map(error)
      }
      loginUiState.status = .error(appError)
      loginUiState.errorMessage = appError.localizedDescription
      Logger.e(tag: "LoginViewModel", message: "Google login failed: \(appError.debugDescription)")
    }
  }
  
  ///  - Animation
  func startAnimation() {
    Task {
      try? await Task.sleep(nanoseconds: 300_000_000)
      withAnimation(.easeOut(duration: 1)) {
        loginUiState.showText = true
      }
    }
  }
  
  // ✅ Navigation
  func navigateToSignUp() {
    Logger.d(tag: "LoginViewModel", message: "Inside navigateToSignUp")
    appCoordinator.navigate(to: .auth(authRoute: .signUp))
  }
  
  func navigateToForgotPassword() {
    Logger.d(tag: "LoginViewModel", message: "Inside navigationToForgotPassword")
    appCoordinator.navigate(to: .auth(authRoute: .forgotPassword))
  }
  
} // 🧱


// MARK: - Helper method
extension LoginViewModel {
  // ✅
  
}
