//
//  SignUpViewModel.swift
//  TaskNest
//
//  Created by Tung Le on 20/6/2025.
//

import Observation
import SwiftUI
import Auth0

@MainActor
@Observable
class SignUpViewModel {
  private var signUpUiState = SignUpUiState()
  var state: SignUpUiState { signUpUiState }
  
  
  // MARK: - Dependencies
  private let authManager: AuthManager
  private let authUseCase: AuthUseCase
  private let appCoordinator: AppCoordinator
  
  var isValidSignUpForm: Bool {
    signUpUiState.isValidSignUpForm
  }
  
  // MARK: Initialiser
  init(authManager: AuthManager, authUseCase: AuthUseCase, appCoordinator: AppCoordinator) {
    self.authManager = authManager
    self.authUseCase = authUseCase
    self.appCoordinator = appCoordinator
  }
  
  // ✅ Update variables & Real-time input error tracking
  
  func updateEmail(_ email: String) {
    signUpUiState.email = email
    
    if email.isEmpty {
      signUpUiState.emailError = "Email cannot be empty."
    } else if !email.contains("@") {
      signUpUiState.emailError = "Invalid email format."
    } else {
      signUpUiState.emailError = ""
    }
  }
  
  func updatePassword(_ password: String) {
    signUpUiState.password = password
    
    if password.isEmpty {
      signUpUiState.passwordError = "Password cannot be empty."
    } else if password.count < SignUpLoginConfig.passwordMinLength {
      signUpUiState.passwordError = "Password too short (min \(SignUpLoginConfig.passwordMinLength))"
    } else if !password.contains(where: \.isUppercase) {
      signUpUiState.passwordError = "Password must contain an uppercase letter."
    } else if !password.contains(where: \.isNumber) {
      signUpUiState.passwordError = "Password must contain a number."
    } else {
      signUpUiState.passwordError = ""
    }
    
    validateConfirmPassword()
  }
  
  func updateConfirmPassword(_ confirmPassword: String) {
    signUpUiState.confirmPassword = confirmPassword
    validateConfirmPassword()
  }
  
  private func validateConfirmPassword() {
    if signUpUiState.confirmPassword != signUpUiState.password {
      signUpUiState.confirmPasswordError = "Passwords do not match."
    } else {
      signUpUiState.confirmPasswordError = ""
    }
  }
  
  // ✅ - Validate input
  private func validateInput() {
    updateEmail(signUpUiState.email)
    updatePassword(signUpUiState.password)
    updateConfirmPassword(signUpUiState.confirmPassword)
  }
  
  // ✅ SignUp with email and password
  func signUpWithEmailAndPassword() async {
    Logger.d(tag: "SignUp", message: "Inside SignUpViewModel - signUp")
    signUpUiState.status = .signingUp
    signUpUiState.errorMessage = nil
    
    guard signUpUiState.isValidSignUpForm else {
      Logger.e(tag: "SignUpViewModel", message: "Invalid form")
      signUpUiState.status = .idle
      return
    }
    
    do {
      let credentials = try await authUseCase.signUpWithEmailAndPassword(email: signUpUiState.email, password: signUpUiState.password)
      authManager.storeCredentials(credentials)
      let authenticatedUser = try await authUseCase.getUserInfo(acceessToken: try authManager.authToken)
      authManager.storeAuthenticatedUser(authenticatedUser)
      signUpUiState.status = .signedUp
      appCoordinator.setRootRoute(.main)
      Logger.d(tag: "SignUpViewModel", message: "Sign up successful with token: \(credentials.accessToken)")
    } catch {
      var appError: AppError
      if case let error as AppError = error {
        appError = error
      } else {
        appError = ErrorMapper.map(error)
      }
      
      signUpUiState.status = .error(appError)
      signUpUiState.errorMessage = appError.localizedDescription
      Logger.e(tag: "SignUpViewModel", message: "Sign up failed: \(appError.debugDescription)")
    }
    
  }
  
  // ✅
  func startAnimation() {
    Task {
      try? await Task.sleep(nanoseconds: 300_000_000)
      withAnimation(.easeOut(duration: 1)) {
        signUpUiState.showText = true
      }
    }
  }
  
  // ✅  - Navigation
  func navigateToLogin() {
//      appCoordinator.setRootRoute(.auth(authRoute: .login))
    appCoordinator.navigate(to: .auth(authRoute: .login))
  }
  
} // 🧱
