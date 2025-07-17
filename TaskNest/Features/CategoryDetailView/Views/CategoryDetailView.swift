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
    
    VStack {
      Text("Category Detail View: name - \(categoryItem.title)")
    }
    .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
            Button("Back") {
                viewModel.goBack()
            }
        }
    }
    .navigationBarBackButtonHidden(true)
  }
}

#Preview {
  let container = AppDIContainer.shared.container
  CategoryDetailView(
    viewModel: CategoryDetailViewModel(
      categoryItem: CategoryItem(title: "Testing Category", userId: "116688"), appCoordinator: container.resolve(AppCoordinator.self)!,
      getTaskItemEntitiesByCategoryEntityUseCase: container.resolve(GetTaskItemEntitiesByCategoryEntityUseCase.self)!)
  )
}
