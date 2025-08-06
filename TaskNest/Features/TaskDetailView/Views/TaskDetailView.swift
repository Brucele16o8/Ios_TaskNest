//
//  TaskDetailView.swift
//  TaskNest
//
//  Created by Tung Le on 22/7/2025.
//

import SwiftUI

struct TaskItemDetailView: View {
  @Bindable var viewModel: TaskItemDetailViewModel
  
  var body: some View {
      VStack {
        Text("Task Detail View - id \(viewModel.taskItem.id)")
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button {
            viewModel.goBack()
          } label: {
            HStack {
              Image(systemName: "chevron.left")
              Text("Task")
            }
            .font(.callout)
            .foregroundStyle(.blue)
          }
        }
      }
      .navigationBarBackButtonHidden(true)
  }
  
} // 🧱

#Preview {
  TaskItemDetailView(
    viewModel: TaskItemDetailViewModel(
      taskItem: TaskItemItem(
        id: UUID(),
        title: "Task tesing",
        isCompleted: true,
        createdAt: .now,
        categoryId: UUID(),
        userId: "12345"),
      appCoordinator: AppCoordinator(),
      errorPresenter: AlertErrorPresenter()
    ))
}
