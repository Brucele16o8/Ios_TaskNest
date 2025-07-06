//
//  CategoryDetailView.swift
//  TaskNest
//
//  Created by Tung Le on 20/6/2025.
//

import SwiftUI

struct CategoryDetailView: View {
  let categoryItem: CategoryItem
  
  var body: some View {
    Text("Category Detail View: name - \(categoryItem.title)")
  }
}

#Preview {
  CategoryDetailView(categoryItem: CategoryItem(title: "Testing Category"))
}
