//
//  CategoryDetailView.swift
//  TaskNest
//
//  Created by Tung Le on 20/6/2025.
//

import SwiftUI

struct CategoryDetailView: View {
  @Bindable private(set) var viewModel: CategoryDetailViewModel
  
  var body: some View {
    let uiState = viewModel.state
    let categoryItem = viewModel.categoryItem
    
    Text("Category Detail View: name - \(categoryItem.title)")
  }
}

#Preview {
  let container = AppDIContainer.shared.container
  CategoryDetailView(
    viewModel: CategoryDetailViewModel(
      categoryItem: CategoryItem(title: "Testing Category", userId: "116688"),
      getTaskItemEntitiesByCategoryEntityUseCase: container.resolve(GetTaskItemEntitiesByCategoryEntityUseCase.self)!)
  )
}
