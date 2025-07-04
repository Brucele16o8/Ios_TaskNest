//
//  CategoryDetailView.swift
//  TaskNest
//
//  Created by Tung Le on 20/6/2025.
//

import SwiftUI

struct CategoryDetailView: View {
  let category: CategoryItem
  
  var body: some View {
    Text("Category Detail View: name - \(category.title)")
  }
}

#Preview {
  CategoryDetailView(category: CategoryItem(title: "Testing Category"))
}
