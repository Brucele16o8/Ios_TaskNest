//
//  updateTaskItemUseCase.swift
//  TaskNest
//
//  Created by Tung Le on 30/6/2025.
//

import Foundation

struct UpdateTaskItemUseCase {
  private let taskItemRepository: TaskItemRepository
  
  init(taskItemRepository: TaskItemRepository) {
    self.taskItemRepository = taskItemRepository
  }
  
  func callAsFunction(taskItem: TaskItem) async throws -> Void {
    try await taskItemRepository.update(taskItem)
  }
}
