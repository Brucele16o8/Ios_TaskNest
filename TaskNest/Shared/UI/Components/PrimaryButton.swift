//
//  PrimaryButton.swift
//  TaskNest
//
//  Created by Tung Le on 17/6/2025.
//

import SwiftUI

struct PrimaryButton<Icon: View>: View {
  let title: String
  let icon: Icon?
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      HStack {
        if let icon = icon {
          icon
        }
        Text(title)
          .fontWeight(.semibold)
      }
      .frame(maxWidth: .infinity)
      .padding()
      .background(Color.blue)
      .foregroundStyle(.white)
      .cornerRadius(10)
    }
  }
}

#Preview {
  PrimaryButton<Image>(title: "PrimaryButton", icon: nil) { }
}
