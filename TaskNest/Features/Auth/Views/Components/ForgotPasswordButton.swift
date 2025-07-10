//
//  ForgotPassowordText.swift
//  TaskNest
//
//  Created by Tung Le on 7/7/2025.
//

import SwiftUI

struct ForgotPassowordText: View {
  let action: () -> Void
  
  var body: some View {
    Button {
      action()
    } label: {
      Text("Forgot password?")
        .underline()
        .foregroundStyle(.white.opacity(0.8))
        .font(.headline)
    }

  }
}

#Preview {
  ForgotPassowordText(action: { })
}
