//
//  LoginViewModel+Bindings.swift
//  TaskNest
//
//  Created by Tung Le on 15/6/2025.
//

import SwiftUI

extension LoginViewModel {
  var emailBinding: Binding<String> {
    Binding (
      get: { self.state.email },
      set: { self.updateEmail($0) }
    )
  }
  
  var passwordBinding: Binding<String> {
    Binding (
      get: { self.state.password },
      set: { self.updatePassword($0) }
    )
  }
}
