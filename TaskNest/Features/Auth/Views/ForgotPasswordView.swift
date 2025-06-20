//
//  ForgotPasswordView.swift
//  TaskNest
//
//  Created by Tung Le on 18/6/2025.
//

import SwiftUI

struct ForgotPasswordView: View {
  var body: some View {
    VStack {
      Text("Forgot Password")
        .font(.title)
        .padding()
      
      Text("Enter your email and we'll send a password reset link.")
        .multilineTextAlignment(.center)
        .padding()
      
      Button("Send Reset Link") {
        // TODO: trigger password reset usecase
      }
      .buttonStyle(.borderedProminent)
      .padding()
    }
  }
}

#Preview {
  ForgotPasswordView()
}
