//
//  SignUpText.swift
//  TaskNest
//
//  Created by Tung Le on 7/7/2025.
//

import SwiftUI

struct SignUpText: View {
  let onSignUpClicked: () -> Void
  
  var body: some View {
    HStack {
      Text("Don't have an account?")
        .foregroundStyle(.gray)
      Button {
        onSignUpClicked()
      } label: {
        Text("Sign Up")
          .bold()
          .underline()
          .foregroundStyle(.white.opacity(0.8))
      }
    }
  }
}

#Preview {
  SignUpText(onSignUpClicked: { })
}
