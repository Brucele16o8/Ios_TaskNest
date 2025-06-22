//
//  Untitled.swift
//  TaskNest
//
//  Created by Tung Le on 22/6/2025.
//

import SwiftUI

struct TextFieldFormPassword: View {
  let title: String
  let bindingPassword: Binding<String>
  @State var isPasswordVisible: Bool = false
  
  
  var body: some View {
    ZStack(alignment: .trailing) {
      Group {
        if isPasswordVisible {
          TextField(title, text: bindingPassword)
        } else {
          SecureField(title, text: bindingPassword)
        }
      }
        .textInputAutocapitalization(.never)
      
      Button(action: {
        isPasswordVisible.toggle()
      }) {
        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
          .foregroundStyle(.secondary)
      }
      .padding(.trailing, 12)
    }
    .padding()
    .background(Color.white)
    .border(Color.gray.opacity(0.1), width: 2)
    .cornerRadius(8)
  }
}

#Preview {
  @Previewable @State var password: String = "abcd_password"
  
  return TextFieldFormPassword(
    title: "Password",
    bindingPassword: $password,
  )
}
