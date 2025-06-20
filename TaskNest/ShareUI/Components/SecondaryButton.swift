//
//  SecondaryButton.swift
//  TaskNest
//
//  Created by Tung Le on 17/6/2025.
//

import SwiftUI

struct SecondaryButton: View {
  let title: String
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      Text(title)
        .fontWeight(.semibold)
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .foregroundStyle(Color.blue)
        .overlay {
          RoundedRectangle(cornerRadius: 10)
            .stroke(Color.blue, lineWidth: 1)
        }
    }
    
  }
}

#Preview {
  SecondaryButton(title: "SecondaryButton") { }
}
