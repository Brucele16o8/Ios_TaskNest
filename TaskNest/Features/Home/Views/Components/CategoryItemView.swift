//
//  CategoryItemView.swift
//  TaskNest
//
//  Created by Tung Le on 5/7/2025.
//

import SwiftUI

struct CategoryItemView: View {
  let categoryItem: CategoryItem
  let onDelete: () -> Void
  
  var body: some View {
    NavigationLink(destination: CategoryDetailView(categoryItem: categoryItem)) {
      CategoryIcon(
        name: categoryItem.title,
        systemIcon: AppCategory.from(title: categoryItem.title).iconName,
        iconSize: 25
      )
    }
    .contextMenu {
      Button("Delete", role: .destructive) {
        onDelete()
      }
    }
  }
}

#Preview {
  CategoryItemView(categoryItem: CategoryItem(title: "work"), onDelete: {})
}
