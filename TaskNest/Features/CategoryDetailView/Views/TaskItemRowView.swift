//
//  TaskItemRowView.swift
//  TaskNest
//
//  Created by Tung Le on 15/7/2025.
//

import SwiftUI

struct TaskItemRowView: View {
  @Bindable private(set) var viewModel: TaskItemViewModel
  @State private var isExpanded = false

  
  var body: some View {
    let taskItem = viewModel.taskItem
    
    DisclosureGroup(isExpanded: $isExpanded) {
      VStack(alignment: .leading, spacing: 16) {
        ForEach(viewModel.subTaskItemViewModels.indices, id: \.self) { index in
          let subTaskItemViewModel = viewModel.subTaskItemViewModels[index]
          SubTaskRowView(
            viewMOdel: subTaskItemViewModel
          )
        }
      }
      .padding(.top, 8)
    } label: {
      HStack {
        Text(taskItem.title)
          .font(.headline)
        Spacer()
        if isExpanded {
          Image(systemName: "cheron.down")
        }
      }
      .contentShape(Rectangle())
    }
    .padding()
    .background(Color.backgroundColor3.opacity(0.6))
    .cornerRadius(12)
  }
}

#Preview {
  let container = AppDIContainer.shared.container
  
  TaskItemRowView(
    viewModel: container.resolve(TaskItemViewModel.self)!
  )
}
