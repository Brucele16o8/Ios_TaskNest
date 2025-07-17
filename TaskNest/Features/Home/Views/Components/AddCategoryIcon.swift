//
//  AddCategoryIcon.swift
//  TaskNest
//
//  Created by Tung Le on 1/7/2025.
//

import SwiftUI

struct AddCategoryIcon: View {
  let iconSize: CGFloat
  let action: () -> Void
  
  var body: some View {
    Button {
      action()
    } label: {
      ZStack {
        RoundedRectangle(cornerRadius: 12)
          .fill(Color.white)
          .frame(width: 68, height: 68)
          .shadow(radius: 1)
        
        Circle()
          .stroke(Color.gray.opacity(0.1), lineWidth: 2)
          .frame(width: iconSize + 16, height: iconSize + 16)
        
        Image(systemName: "plus")
          .font(.system(size: iconSize, weight: .medium))
          .foregroundColor(.gray.opacity(0.5))
      }
    }
  }
}


#Preview {
  AddCategoryIcon(
    iconSize: 25
  ) { }
}
