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
  
  private let errorPresenter: ErrorPresenter
  
  init(
    taskItem: TaskItemItem,
    onDelete: @escaping (UUID) async throws -> Void,
    onUpdate: @escaping (TaskItemEntity) async throws -> Void,
    onCliked: @escaping (TaskItemItem) -> Void,
    errorPresenter: ErrorPresenter
  ) {
    self.taskItem = taskItem
    self.onDelete = onDelete
    self.onUpdate = onUpdate
    self.onCliked = onCliked
    self.errorPresenter = errorPresenter
  }
  
  // MARK: TaskItem manipulation
  func delteTaskItem() async {
    do {
      try await onDelete(taskItem.id)
    } catch {
      errorPresenter.present(error)
    }
  }
  
  func updateTaskItem() async {
    do {
      try await onUpdate(taskItem.mapToEntity)
    } catch {
      errorPresenter.present(error)
    }
  }
  
  func toggleCompletion() async {
    taskItem.isCompleted.toggle()
    await updateTaskItem()
  }
  
  // MARK: Navigation
  
} // 🧱
