//
//  Untitled.swift
//  TaskNest
//
//  Created by Tung Le on 7/7/2025.
//

import SwiftUI

extension SignUpViewModel {
  var emailBinding: Binding<String> {
    Binding(
      get: { self.state.email },
      set: { self.updateEmail($0) }
    )
  }
  
  var passwordBinding: Binding<String> {
    Binding(
      get: { self.state.password },
      set: { self.updatePassword($0) }
    )
  }
  
  var confirmPasswordBinding: Binding<String> {
    Binding(
      get: { self.state.confirmPassword },
      set: { self.updateConfirmPassword($0) }
    )
  }
  
//  var userNameBinding: Binding<String> {
//    Binding(
//      get: { self.state.userName },
//      set: { self.updateUserName($0) }
//    )
//  }
  
} 
