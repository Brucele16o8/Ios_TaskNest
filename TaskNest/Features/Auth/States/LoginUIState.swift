//
//  LoginUIState.swift
//  TaskNest
//
//  Created by Tung Le on 14/6/2025.
//

struct LoginUIState: Equatable {
  var email: String = ""
  var password: String = ""
  var status: LoginStatus = .idle
  var showText = false
  
  var isAuthenticating: Bool { status == .authenticating }
  var isAuthenticated: Bool { status == .authenticated }
  var isLoginDisable: Bool { email.isEmpty || password.isEmpty || isAuthenticating }
  
  var isValidLoginForm: Bool {
    !email.isEmpty && email.contains("@") &&
    !password.isEmpty && password.count >= PasswordConfig.minLength
  }
}


