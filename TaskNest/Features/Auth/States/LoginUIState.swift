//
//  LoginUIState.swift
//  TaskNest
//
//  Created by Tung Le on 14/6/2025.
//

struct LoginUIState: Equatable {
  // MARK: - Type
  enum LoginStatus: Equatable {
    case idle
    case authenticating
    case authenticated
    case error(Error)
    
    static func ==(lhs: LoginStatus, rhs: LoginStatus) -> Bool {
      switch (lhs, rhs) {
      case (.idle, .idle),
        (.authenticating, .authenticating),
        (.authenticated, .authenticated):
        return true
      case (.error(let lhsError), .error(let rhsError)):
        return lhsError.localizedDescription == rhsError.localizedDescription
      default:
        return false
      }
    }
  }
  
  var status: LoginStatus = .idle
  var email: String = ""
  var password: String = ""
  var errorMessage: String?
  var emailError: String = ""
  var passwordError: String = ""
  var showText: Bool = false
  
  var isLoginDisabled: Bool {
    email.isEmpty || password.isEmpty || status == .authenticating || !emailError.isEmpty || !passwordError.isEmpty
  }
  
  var isValidLoginForm: Bool {
    !email.isEmpty &&
    email.contains("@") &&
    !password.isEmpty &&
    password.count >= SignUpLoginConfig.passwordMinLength &&
    password.contains(where: \.isUppercase) &&
    password.contains(where: \.isNumber)
  }
  
}


