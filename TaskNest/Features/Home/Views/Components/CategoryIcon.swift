//
//  CategoryIcon.swift
//  TaskNest
//
//  Created by Tung Le on 30/6/2025.
//

import SwiftUI

struct CategoryIcon: View {
  let name: String
  let systemIcon: String
  let iconColor: Color = AppColor.allValues.randomElement() ?? .gray
  let iconSize: CGFloat
  
  var body: some View {
    VStack {
      Image(systemName: systemIcon)
        .font(.custom("Category Icons", size: iconSize))
        .fontWeight(.bold)
        .foregroundStyle(iconColor)
        .frame(width: 68, height: 68)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 1)
      Text(name)
        .font(.caption)
        .fontWeight(.semibold)
    }
  }
}


#Preview {
  CategoryIcon(
    name: "Work",
    systemIcon: AppCategory.from(title: "work").iconName,
    iconSize: 25
  )
}
