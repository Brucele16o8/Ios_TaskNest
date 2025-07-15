//
//  ForgotPasswordViewModel+Binding.swift
//  TaskNest
//
//  Created by Tung Le on 15/7/2025.
//

import SwiftUI

extension ForgotPasswordViewModel {
  var emailBinding: Binding<String> {
    Binding (
      get: { self.uitState.email },
      set: { self.updateEmail($0) }
    )
  }
}
