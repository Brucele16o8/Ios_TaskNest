//
//  ForgotPasswordUIState.swift
//  TaskNest
//
//  Created by Tung Le on 15/7/2025.
//

import Foundation

struct ForgotPasswordUIState {
  var isSubmitting: Bool = false
  var errorMessage: String? = nil
  var email: String = ""
  var successMessage: String? = nil
  var showText: Bool = false
  
  var isButtonDisabled: Bool {
    isSubmitting || email.isEmpty
  }
}
