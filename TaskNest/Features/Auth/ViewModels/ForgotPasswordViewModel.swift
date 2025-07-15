//
//  ForgotPasswordViewModel.swift
//  TaskNest
//
//  Created by Tung Le on 15/7/2025.
//

import Foundation
import SwiftUI

@MainActor
@Observable
final class ForgotPasswordViewModel {
  private var forgotPasswordUiState = ForgotPasswordUIState()
  var uitState: ForgotPasswordUIState { forgotPasswordUiState }
  private let authUseCase: AuthUseCase
  
  var isButtonDisabled: Bool {
    forgotPasswordUiState.isButtonDisabled
  }
  
  init(authUseCase: AuthUseCase) {
    self.authUseCase = authUseCase
  }
  
  // ✅
  func updateEmail(_ email: String) {
    forgotPasswordUiState.email = email
  }
  
  // ✅
  func submit() async {
    forgotPasswordUiState.isSubmitting = true
    forgotPasswordUiState.errorMessage = nil
    forgotPasswordUiState.successMessage = nil
    
    do {
      try await authUseCase.resetPasswordUseCase(email: forgotPasswordUiState.email)
      forgotPasswordUiState.successMessage = "Reset link sent to your email"
    } catch {
      var appError: AppError
      if case let error as AppError = error {
        appError = error
      } else {
        appError = ErrorMapper.map(error)
      }
      
      forgotPasswordUiState.errorMessage = appError.localizedDescription
      Logger.e(tag: "ForgotPasswordUiState", message: "Reserve password failed: \(appError.debugDescription)")
    }
    forgotPasswordUiState.isSubmitting = false
  }
  
  ///  - Animation
  func startAnimation() {
    Task {
      try? await Task.sleep(nanoseconds: 300_000_000)
      withAnimation(.easeOut(duration: 1)) {
        forgotPasswordUiState.showText = true
      }
    }
  }
  
} // 🧱
