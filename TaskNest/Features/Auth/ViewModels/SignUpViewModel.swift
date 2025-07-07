//
//  SignUpViewModel.swift
//  TaskNest
//
//  Created by Tung Le on 20/6/2025.
//

import Observation
import SwiftUI
import Auth0

@Observable
class SignUpViewModel {
  private var signUpState = SignUpUIState()
  private var appError: AppError?
  
  var state: SignUpUIState { signUpState }
  var error: AppError? { appError }
  
  // MARK: - Dependencies
  private let authManager: AuthManager
  private let authUseCase: AuthUseCase
  
  var isValidForm: Bool {
    signUpState.isValidForm
  }
  
  // MARK: Initialiser
  init(authManager: AuthManager, authUseCase: AuthUseCase) {
    self.authManager = authManager
    self.authUseCase = authUseCase
  }
  
  // ✅ Update variables & Real-time input error tracking
  
  func updateEmail(_ email: String) {
    signUpState.email = email
    
    if email.isEmpty {
      signUpState.emailError = "Email cannot be empty."
    } else if !email.contains("@") {
      signUpState.emailError = "Invalid email format."
    } else {
      signUpState.emailError = ""
    }
  }
  
  func updatePassword(_ password: String) {
    signUpState.password = password
    
    if password.isEmpty {
      signUpState.passwordError = "Password cannot be empty."
    } else if password.count < SignUpLoginConfig.passwordMinLength {
      signUpState.passwordError = "Password too short (min \(SignUpLoginConfig.passwordMinLength))"
    } else if !password.contains(where: \.isUppercase) {
      signUpState.passwordError = "Password must contain an uppercase letter."
    } else if !password.contains(where: \.isNumber) {
      signUpState.passwordError = "Password must contain a number."
    } else {
      signUpState.passwordError = ""
    }
    
    validateConfirmPassword()
  }
  
  func updateConfirmPassword(_ confirmPassword: String) {
    signUpState.confirmPassword = confirmPassword
    validateConfirmPassword()
  }
  
  private func validateConfirmPassword() {
    if signUpState.confirmPassword != signUpState.password {
      signUpState.confirmPasswordError = "Passwords do not match."
    } else {
      signUpState.confirmPasswordError = ""
    }
  }
  
//  func updateUserName(_ userName: String) {
//    signUpState.userName = userName
//    
//    if userName.isEmpty {
//      signUpState.userNameError = "Username cannot be empty."
//    } else if userName.count < SignUpLoginConfig.userNameMinLength {
//      signUpState.userNameError = "Username too short (min \(SignUpLoginConfig.userNameMinLength))"
//    } else {
//      signUpState.userNameError = ""
//    }
//  }
  
  // ✅ - Validate input
  private func validateInput() {
    updateEmail(signUpState.email)
    updatePassword(signUpState.password)
    updateConfirmPassword(signUpState.confirmPassword)
//    updateUserName(signUpState.userName)
  }
  
  // ✅ SignUp with email and password
  func signUpWithEmailAndPassword() {
    Logger.d(tag: "SignUp", message: "Inside SignUpViewModel - signUpWithEmailAndPassword")
    
    validateInput()
    
    Logger.d(tag: "SignUp", message: "emai: \(signUpState.email), password: \(signUpState.password)")
    let hasError = [
      signUpState.emailError,
      signUpState.passwordError,
      signUpState.confirmPasswordError,
      signUpState.userNameError
    ].contains(where: { !$0.isEmpty })
    
    guard !hasError else {
      signUpState.status = .error
      return
    }
    Logger.d(tag: "SignUp", message: "There is no validation error")
    appError = nil
    
    authUseCase.signUpWithEmailAndPassword(
      email: signUpState.email,
      password: signUpState.password
    ) { [weak self] result in
      self?.handleSignUpResult(result)
    }
  }
  
  /// ++  Helper method
  private func handleSignUpResult(_ result: Result<Credentials, AppError>) {
    Task { @MainActor in
      switch result {
      case .success(let credentials):
        self.authManager.storeCredentials(credentials)
        signUpState.status = .signedUp
        authManager.updateAuthStateIfNeeded(from: signUpState.status)
        
        Logger.d(tag: "SignUp", message: "Inside SignUpViewModel - handleSignUpResult")
        Logger.d(tag: "SignUp", message: "SignUp Status: \(signUpState.status)")
        Logger.d(tag: "SignUp", message: "Auth Manager status: \(authManager.authState)")
        
      case .failure(let error):
        appError = error.toAppError
        signUpState.status = .error
        authManager.updateAuthStateIfNeeded(from: signUpState.status)
        
        Logger.d(tag: "SignUp", message: "Inside SignUpViewModel - handleSignUpResult")
        Logger.d(tag: "SignUp", message: "SignUp Status: \(signUpState.status)")
        Logger.d(tag: "SignUp", message: "Auth Manager status: \(authManager.authState)")
        Logger.e(tag: "SignUp", message: "Error while authenticating: \(error)")
      }
    }
  }
  
  // ✅
  func startAnimation() {
    Task {
      try? await Task.sleep(nanoseconds: 300_000_000)
      withAnimation(.easeOut(duration: 1)) {
        signUpState.showText = true
      }
    }
  }
  
} // 🧱
