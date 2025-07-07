//
//  SignUpLoginText.swift
//  TaskNest
//
//  Created by Tung Le on 7/7/2025.
//

import SwiftUI

struct SignUpLoginText: View {
  var onTap: () -> Void

  var body: some View {
    HStack {
      Text("Already have an account?")
        .foregroundColor(.gray)
      Button(action: onTap) {
        Text("Log in")
          .fontWeight(.semibold)
          .foregroundColor(.blue)
      }
    }
    .font(.subheadline)
    .padding(.top, 8)
  }
}

#Preview {
  SignUpLoginText(onTap: { print("Tapped") })
}
