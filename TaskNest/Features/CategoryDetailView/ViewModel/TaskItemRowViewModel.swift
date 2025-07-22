//
//  t.swift
//  TaskNest
//
//  Created by Tung Le on 16/7/2025.
//

import Foundation

@Observable
final class TaskItemRowViewModel {
  var taskItem: TaskItemItem
  var onDelete: (UUID) async throws -> Void
  var onUpdate: (TaskItemEntity) async throws -> Void
  var onCliked: (TaskItemItem) -> Void
  var errorMessage: String = ""
  
  init(
    taskItem: TaskItemItem,
    onDelete: @escaping (UUID) async throws -> Void,
    onUpdate: @escaping (TaskItemEntity) async throws -> Void,
    onCliked: @escaping (TaskItemItem) -> Void
  ) {
    self.taskItem = taskItem
    self.onDelete = onDelete
    self.onUpdate = onUpdate
    self.onCliked = onCliked
  }
  
  // MARK: TaskItem manipulation
  func updateTaskItem() async throws {
    try await onUpdate(taskItem.mapToEntity)
  }
  
  func toggleCompletion() async {
    taskItem.isCompleted.toggle()
    do {
      try await updateTaskItem()
    } catch let appError as AppError {
      errorMessage = appError.localizedDescription
    } catch {
      errorMessage = "Error when fetching photoAttachment items"
    }
  }
  
  // MARK: Navigation
  
} // 🧱
