//
//  SignUpState.swift
//  TaskNest
//
//  Created by Tung Le on 7/7/2025.
//

struct SignUpUIState {
  var email: String = ""
  var password: String = ""
//  var userName: String = ""
  var confirmPassword: String = ""
  var showText: Bool = false
  var status: SignUpStatus = .idle
  
  var isSigningUp: Bool { status == .signingUp }
  var isAuthenticated: Bool { status == .signedUp }
  var isSignUpDisable: Bool { email.isEmpty || password.isEmpty || isSigningUp }
  
  var isValidLoginForm: Bool {
    !email.isEmpty && email.contains("@") &&
    !password.isEmpty && password.count >= SignUpLoginConfig.passwordMinLength
  }
  
  var isValidForm: Bool {
    return !email.isEmpty &&
    email.contains("@") &&
    !password.isEmpty &&
    password.count >= SignUpLoginConfig.passwordMinLength &&
    password.contains(where: \.isUppercase) &&
    password.contains(where: \.isNumber) &&
    password == confirmPassword
  }
  
  // real time error message
  var emailError: String = ""
  var passwordError: String = ""
  var confirmPasswordError: String = ""
  var userNameError: String = ""
  
} // 🧱

