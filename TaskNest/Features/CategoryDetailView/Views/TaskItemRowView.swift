//
//  TaskItemRowView.swift
//  TaskNest
//
//  Created by Tung Le on 15/7/2025.
//

import SwiftUI

struct TaskItemRowView: View {
  @Bindable private(set) var viewModel: TaskItemRowViewModel
  @State private var isExpanded = false
  
  
  var body: some View {
    let taskItem = viewModel.taskItem
    
    HStack(spacing: 12) {
      Button {
        Task { await viewModel.toggleCompletion() }
      } label: {
        Image(systemName: taskItem.isCompleted ? "checkmark.circle.fill" : "circle")
          .foregroundColor(.blue)
          .font(.system(size: 22))
      }
      .buttonStyle(.plain)
      
      Text(taskItem.title)
        .font(.subheadline)
        .foregroundStyle(taskItem.isCompleted ? .gray : .primary)
        .strikethrough(taskItem.isCompleted)
      
      Spacer()
      
      Image(systemName: "chevron.right")
        .foregroundStyle(.gray)
        .font(.system(size: 14, weight: .semibold))
    }
    .contentShape(Rectangle())
    .onTapGesture {
      viewModel.onCliked(taskItem)
    }
    .padding()
    .background(
      ZStack {
        RoundedRectangle(cornerRadius: 12)
          .fill(Color.white)
        RoundedRectangle(cornerRadius: 12)
          .fill(Color.backgroundColor3.opacity(0.6))
      }
    )
    .overlay {
      RoundedRectangle(cornerRadius: 12)
        .stroke(Color.gray.opacity(0.25), lineWidth: 1)
    }
    .swipeActions {
      Button(role: .destructive) {
        Task {
          await viewModel.delteTaskItem()
        }
      } label: {
        Label("Delete", systemImage: "trash")
      }
    }
  }
}

#Preview {
  let container = AppDIContainer.shared.container
  
  TaskItemRowView(
    viewModel: TaskItemRowViewModel(
      taskItem: TaskItemEntity.taskItem2.maptoTaskItemItem,
      onDelete: { _ in },
      onUpdate: { _ in },
      onCliked: { _ in }
    )
  )
}
