//
//  SignUpState.swift
//  TaskNest
//
//  Created by Tung Le on 7/7/2025.
//

struct SignUpUiState {
  // MARK: - Type
  enum SignUpStatus: Equatable {
    case idle
    case signingUp
    case signedUp
    case error(Error)
    
    static func ==(lhs: SignUpStatus, rhs: SignUpStatus) -> Bool {
      switch (lhs, rhs) {
      case (.idle, .idle),
        (.signingUp, .signingUp),
        (.signedUp, .signedUp):
        return true
      case (.error(let lhsError), .error(let rhsError)):
        return lhsError.localizedDescription == rhsError.localizedDescription
      default:
        return false
      }
    }    
  }
  
  var status: SignUpStatus = .idle
  
  var email: String = ""
  var password: String = ""
  var confirmPassword: String = ""
  var showText: Bool = false
  
  // real time error message
  var emailError: String = ""
  var passwordError: String = ""
  var confirmPasswordError: String = ""
  var userNameError: String = ""
  
  var errorMessage: String?
  
  var isSignUpDisabled: Bool {
    email.isEmpty ||
    password.isEmpty ||
    confirmPassword.isEmpty ||
    status == .signingUp ||
    !emailError.isEmpty ||
    !passwordError.isEmpty ||
    !confirmPasswordError.isEmpty ||
    !userNameError.isEmpty
  }
  
  var isValidSignUpForm: Bool {
    !email.isEmpty &&
    email.contains("@") &&
    !password.isEmpty &&
    password.count >= SignUpLoginConfig.passwordMinLength &&
    password.contains(where: \.isUppercase) &&
    password.contains(where: \.isNumber) &&
    confirmPassword == password
  }
  
  
} // 🧱

