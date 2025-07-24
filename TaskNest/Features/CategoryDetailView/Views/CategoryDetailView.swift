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
  @StateObject private var presenter: AlertErrorPresenter
  
  init(viewModel: CategoryDetailViewModel) {
    _viewModel = Bindable(wrappedValue: viewModel)
    _presenter = StateObject(wrappedValue: viewModel.errorPresenter)
  }
  
  var body: some View {
    ZStack {
      Color.backgroundColor3
        .ignoresSafeArea()
      
      VStack(spacing: 0) {
        ScrollView {
          LazyVStack(spacing: 0){
            ForEach(viewModel.taskItemViewModels.indices, id: \.self) { index in
              let taskItemViewModel = viewModel.taskItemViewModels[index]
              TaskItemRowView(viewModel: taskItemViewModel)
            }
          }
        }
        
        Spacer()
        // Fixed Input Field
        HStack(spacing: 12) {
          TextField("Add a Task", text: viewModel.newTaskTitleBinding, onCommit: {
            Task { await viewModel.addNewTaskItem() }
          })
          .textFieldStyle(.plain)
          .padding(12)
          .background(Color(.systemGray6))
          .cornerRadius(10)
          .focused($isTextFieldFocused)

          Button {
            Task { await viewModel.addNewTaskItem() }
          } label: {
            Image(systemName: "plus")
              .foregroundColor(.white)
              .padding(10)
              .background(
                viewModel.state.newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                  ? Color.gray
                  : Color.blue
              )
              .clipShape(Circle())
          }
          .disabled(viewModel.state.newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
        .padding(.horizontal)
        .padding(.top, 8)
        .padding(.bottom, 12)
        .background(.ultraThinMaterial)
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
    .alert(item: $presenter.currentError) { error in
      Alert(
        title: Text(error.title),
        message: Text(error.description),
        dismissButton: .default(Text("OK"))
      )
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
      deleteTaskItemEntityUseCase: container.resolve(DeleteTaskItemEntityUseCase.self)!, saveTaskItemEntityUseCase: container.resolve(SaveTaskItemEntityUseCase.self)!,
      errorPresenter: container.resolve(AlertErrorPresenter.self)!
    )
  )
}
