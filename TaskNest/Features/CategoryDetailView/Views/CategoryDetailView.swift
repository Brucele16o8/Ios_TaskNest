//
//  CategoryDetailView.swift
//  TaskNest
//
//  Created by Tung Le on 20/6/2025.
//

import SwiftUI

struct CategoryDetailView: View {
  @Bindable private(set) var viewModel: CategoryDetailViewModel
  @FocusState private var isTextFieldFocused: Bool
  
  var body: some View {
//        let uiState = viewModel.state
//        let categoryItem = viewModel.categoryItem
    
    ZStack {
      Color.backgroundColor4
        .ignoresSafeArea()
      
      VStack(spacing: 0) {
        ForEach(viewModel.taskItemViewModels.indices, id: \.self) { index in
          let taskItemViewModel = viewModel.taskItemViewModels[index]
          TaskItemRowView(viewModel: taskItemViewModel)
        }
        
        HStack {
          TextField("Add new task ...", text: viewModel.newTaskTitleBinding)
            .textFieldStyle(.roundedBorder)
            .focused($isTextFieldFocused)
        }
        if isTextFieldFocused {
          Button("Done") {
            Task {
              await viewModel.addNewTaskItem()
            }
            
          }
        }
      } /// VStack
    } /// ZStack
    .task {
      await viewModel.start()
    }
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Button {
          viewModel.goBack()
        } label: {
          HStack {
            Image(systemName: "chevron.left")
            Text("Categories")
          }
          .font(.callout)
          .foregroundStyle(.blue)
        }
      }
    }
    .navigationBarBackButtonHidden(true)

  }
} /// End-View

#Preview {
  let container = AppDIContainer.shared.container
  CategoryDetailView(
    viewModel: CategoryDetailViewModel(
      categoryItem: CategoryItem(title: "Testing Category", userId: "116688"),
      appCoordinator: container.resolve(AppCoordinator.self)!,
      authManager: container.resolve(AuthManager.self)!,
      getTaskItemEntitiesByCategoryEntityUseCase: GetTaskItemEntitiesByCategoryEntityUseCase(
        taskItemRepository: MockTaskItemRepository()),
      updateTaskItemEntityUseCase: container.resolve(UpdateTaskItemEntityUseCase.self)!,
      deleteTaskItemEntityUseCase: container.resolve(DeleteTaskItemEntityUseCase.self)!, saveTaskItemEntityUseCase: container.resolve(SaveTaskItemEntityUseCase.self)!
    )
  )
}
