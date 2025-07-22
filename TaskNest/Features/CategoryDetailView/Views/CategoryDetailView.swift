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
    //    let uiState = viewModel.state
    //    let categoryItem = viewModel.categoryItem
    
    VStack {
      ForEach(viewModel.taskItemViewModels.indices, id: \.self) { index in
        let taskItemViewModel = viewModel.taskItemViewModels[index]
        TaskItemRowView(viewModel: taskItemViewModel)
        if index < viewModel.taskItemViewModels.count - 1 {
          // Thin divider between subtasks
          Divider()
            .frame(height: 0.5)
            .background(Color.gray.opacity(0.3))
            .padding(.vertical, 4)
        }
      }
    }
    .task {
      await viewModel.start()
    }
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Button("Back") {
          viewModel.goBack()
        }
      }
    }
    .navigationBarBackButtonHidden(true)
    .background(Color.backgroundColor3)
  }
}

#Preview {
  let container = AppDIContainer.shared.container
  CategoryDetailView(
    viewModel: CategoryDetailViewModel(
      categoryItem: CategoryItem(title: "Testing Category", userId: "116688"),
      appCoordinator: container.resolve(AppCoordinator.self)!,
      getTaskItemEntitiesByCategoryEntityUseCase: GetTaskItemEntitiesByCategoryEntityUseCase(
        taskItemRepository: MockTaskItemRepository()),
      updateTaskItemEntityUseCase: container.resolve(UpdateTaskItemEntityUseCase.self)!,
      deleteTaskItemEntityUseCase: container.resolve(DeleteTaskItemEntityUseCase.self)!
    )
  )
}
