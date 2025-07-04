//
//  TextFiledForm.swift
//  TaskNest
//
//  Created by Tung Le on 22/6/2025.
//

import SwiftUI

struct TextFieldFormGeneral: View {
  let title: String
  let bindingText: Binding<String>
  let keyboardType: UIKeyboardType?
  
  
  var body: some View {
    TextField(title, text: bindingText)
      .textInputAutocapitalization(.never)
      .keyboardType(keyboardType ?? .default)
      .padding()
      .background(Color.white)
      .border(Color.gray.opacity(0.1), width: 2)
      .cornerRadius(8)
  }
}

#Preview {
  TextFieldFormGeneral(
    title: "Email",
    bindingText: .constant("testing@gmail.com"),
    keyboardType: UIKeyboardType.emailAddress
  )
}
